import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/document/prenstation/view/addnewdocument.dart';
import 'package:collab_doc/feature/document/prenstation/view/document_page.dart';
import 'package:collab_doc/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/apparhome.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/texthome.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> documents = [];
  List<Team> teams = [];
  Dio dio = Dio();
  bool _isLoading = true;

  @override
  void initState() {
    //BlocProvider.of<HomeCubit>(context).getUserDetails();
    _loadDocuments();
    super.initState();
  }

  Future<void> _loadDocuments() async {
    final _firebase = FirebaseFirestore.instance;
    var response = await dio.get(
      Applink.apiGetTheTeamAsMemeber,
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${infoUserSharedPreferences.getString("token")}",
        },
      ),
    );
    var response2 = await dio.get(
      Applink.apiGetMyteam,
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${infoUserSharedPreferences.getString("token")}",
        },
      ),
    );
    for (var item in response.data) {
      teams.add(Team.fromJson(item));
    }

    List<Map<String, dynamic>> listDocument = [];
    for (var item in response2.data) {
      teams.add(Team.fromJson(item));
    }

    //teams.add(response2.data as List);
    for (Team item in teams) {
      //String? id = sharedPreferences.getString("id");
      var res = await _firebase
          .collection("documents")
          .where("teamId", isEqualTo: item.id)
          .get();

      for (var a in res.docChanges) {
        listDocument.add(a.doc.data()!);
      }
    }
    print(listDocument);

    setState(() {
      documents = listDocument;
    });
  }

  Future<void> _deleteDocument(String id) async {
    await FirebaseFirestore.instance.collection("documents").doc(id).delete();
    setState(() {}); // Refresh UI
  }

  void _openDocument(String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => /* AddDocumentPage(content)*/
            DocumentPage(docId: content),
      ),
    );
  }

  void showAddDocumentDialog() {
    final TextEditingController _titleController = TextEditingController();
    Team? selectedTeam;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Document'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Document Title'),
              ),
              DropdownButton<Team>(
                hint: Text('Select Team'),
                value: selectedTeam,
                onChanged: (Team? newValue) {
                  setState(() {
                    selectedTeam = newValue;
                  });
                  // Needed to reflect selection inside the dialog
                  (context as Element).markNeedsBuild();
                },
                items: teams.map((team) {
                  return DropdownMenuItem(
                    value: team,
                    child: Text(team.name),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                final title = _titleController.text.trim();
                if (title.isNotEmpty && selectedTeam != null) {
                  final docRef =
                      FirebaseFirestore.instance.collection('documents').doc();
                  await docRef.set({
                    'idDocument': docRef.id,
                    'titre': title,
                    'teamId': selectedTeam!.id,
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is UserFailure) {
              snackbarerror(context, state.errorMessage);
            } else if (state is UserSuccess) {
              infoUserSharedPreferences.setString(
                  "username", state.userDetails.username);
              infoUserSharedPreferences.setString(
                  "email", state.userDetails.email);
              infoUserSharedPreferences.setString(
                  "id", state.userDetails.id.toString());
              infoUserSharedPreferences.setString(
                  "active", state.userDetails.active.toString());
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  ApparHome(),
                  SizedBox(
                    height: 20,
                  ),
                  Texthome(text: "Recent Document"),
                  documents.isEmpty
                      ? Center(child: Text("No documents saved."))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final doc = documents[index];

                              return Card(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(" ${doc["titre"]} "),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        _deleteDocument(doc['idDocument']!),
                                  ),
                                  onTap: () =>
                                      _openDocument(doc['idDocument']!),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          showAddDocumentDialog();
        },
      ),
    );
  }
}
