import 'dart:convert';
import 'package:collab_doc/feature/document/prenstation/view/addnewdocument.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/apparhome.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/texthome.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> documents = [];
  @override
  void initState() {
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
        child: Column(
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
                              onPressed: () => _deleteDocument(doc['id']!),
                            ),
                            onTap: () => _openDocument(doc['content']!),
                          ),
                        );
                      },
                    ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddDocumentPage("")),
        ).then((_) => _loadDocuments()),
      ),
    );
  }
}




