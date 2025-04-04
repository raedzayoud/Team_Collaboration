import 'package:collab_doc/feature/document/prenstation/view/widgets/buttons.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/cursordocument.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert';

import 'package:speech_to_text/speech_to_text.dart' as stt;

class AddDocumentPage extends StatefulWidget {
  final String? initialContent;
  const AddDocumentPage(this.initialContent);
  @override
  _AddDocumentPageState createState() => _AddDocumentPageState();
}

class _AddDocumentPageState extends State<AddDocumentPage> {
  final quill.QuillController _controller = quill.QuillController.basic();
  stt.SpeechToText speechToText = stt.SpeechToText();
  TextEditingController _textEditingController = TextEditingController();

  bool _speechEnalbled = false;
  String _wordSpoken = "";

  void startListening() async {
    if (!_speechEnalbled) {
      return;
    }
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void onSpeechResult(result) {
    setState(() {
      _wordSpoken = "${result.recognizedWords}";
    });
    if (_wordSpoken.isNotEmpty) {
      // Get current selection position
      final selection = _controller.selection;

      // Insert the spoken text at the current cursor position
      _controller.document.insert(selection.baseOffset, "$_wordSpoken ");

      // Move cursor to the new position
      _controller.updateSelection(
        TextSelection.collapsed(
            offset: selection.baseOffset + _wordSpoken.length + 1),
        ChangeSource.local,
      );
    }
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void init() async {
    _speechEnalbled = await speechToText.initialize();
    setState(() {});
  }

  // Save document to SharedPreferences
  Future<void> _saveDocument() async {
    // Retrieve existing documents list or initialize an empty list
    List<String> savedDocs =
        sharedPreferences.getStringList('saved_documents') ?? [];

    // Create a new document entry
    final String jsonContent =
        jsonEncode(_controller.document.toDelta().toJson());
    final String documentId =
        DateTime.now().millisecondsSinceEpoch.toString(); // Unique ID
    final Map<String, String> newDoc = {
      "id": documentId,
      "content": jsonContent,
    };

    // Add the new document to the list
    savedDocs.add(jsonEncode(newDoc));

    // Save the updated list
    await sharedPreferences.setStringList('saved_documents', savedDocs);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Document saved successfully!")),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    init();
    // Load the existing document if provided
    if (widget.initialContent != null) {
      try {
        final List<dynamic> deltaJson = jsonDecode(widget.initialContent!);
        _controller.document = quill.Document.fromJson(deltaJson);
        // Set the cursor to the beginning or end of the document
        _controller.updateSelection(
          TextSelection.collapsed(offset: _controller.document.length),
          ChangeSource.local,
        );
      } catch (e) {
        print("Error loading document: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Document"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.content_cut_outlined),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Resume Text Summarizer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: TextFormField(
                        readOnly: true,
                        /**controller: _textEditingController..text = _controller.document.toPlainText(),
                         *  This is equivalent to:
                         * _textEditingController.text = _controller.document.toPlainText();
                            controller: _textEditingController;
                        */
                        controller: _textEditingController
                          ..text = _controller.document.toPlainText(),
                        scrollPadding: EdgeInsets.all(20),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      actions: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.deepPurple,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Apply Resume",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ],
                    );
                  });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Add the toolbox here
          QuillSimpleToolbar(
            controller: _controller,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Cursordocument(
                controller: _controller,
              ),
            ),
          ),

          Buttons(
            startListening: startListening,
            stopListening: stopListening,
            speechToText: speechToText,
            save: _saveDocument,
          ),
        ],
      ),
    );
  }
}
