import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';  // ✅ Import toolbar
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddDocumentPage extends StatefulWidget {
  @override
  _AddDocumentPageState createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  // Save document to SharedPreferences
  Future<void> _saveDocument() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonContent = jsonEncode(_controller.document.toDelta().toJson());
    await prefs.setString('saved_document', jsonContent);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Document saved locally!")),
    );

    Navigator.pop(context);
  }

  // Load saved document from SharedPreferences
  Future<void> _loadDocument() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedJson = prefs.getString('saved_document');

    if (savedJson != null) {
      try {
        final List<dynamic> deltaJson = jsonDecode(savedJson);
        setState(() {
          _controller.document = quill.Document.fromJson(deltaJson);
        });
      } catch (e) {
        print("Error loading document: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Document")),
      body: Column(
        children: [
          // Add the toolbox here
          QuillSimpleToolbar(controller: _controller,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: quill.QuillEditor(
                controller: _controller,
                focusNode: _focusNode,
                scrollController: _scrollController,
                config: quill.QuillEditorConfig(
                  readOnlyMouseCursor: SystemMouseCursors.basic,
                 ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel),
                  label: Text("Cancel"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                ElevatedButton.icon(
                  onPressed: _saveDocument,
                  icon: Icon(Icons.save),
                  label: Text("Save"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
