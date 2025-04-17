import 'dart:convert';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/document/prenstation/view/addnewdocument.dart';
import 'package:collab_doc/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/apparhome.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/texthome.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> documents = [];

  @override
  void initState() {
    //BlocProvider.of<HomeCubit>(context).getUserDetails();
    _loadDocuments();
    super.initState();
  }

  Future<void> _loadDocuments() async {
    List<String> savedDocs =
        sharedPreferences.getStringList('saved_documents') ?? [];

    setState(() {
      documents = savedDocs
          .map((doc) => Map<String, String>.from(jsonDecode(doc)))
          .toList();
    });
  }

  Future<void> _deleteDocument(String id) async {
    List<String> savedDocs =
        sharedPreferences.getStringList('saved_documents') ?? [];

    // Remove the document with matching ID
    savedDocs.removeWhere((doc) {
      final decodedDoc = jsonDecode(doc);
      return decodedDoc['id'] == id;
    });

    await sharedPreferences.setStringList('saved_documents', savedDocs);
    _loadDocuments(); // Refresh UI
  }

  void _openDocument(String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDocumentPage(content),
      ),
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
                                  title: Text("Document ${index + 1}"),
                                  subtitle: Text("ID: ${doc['id']}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () =>
                                        _deleteDocument(doc['id']!),
                                  ),
                                  onTap: () => _openDocument(doc['content']!),
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddDocumentPage("")),
        ).then((_) => _loadDocuments()),
      ),
    );
  }
}
