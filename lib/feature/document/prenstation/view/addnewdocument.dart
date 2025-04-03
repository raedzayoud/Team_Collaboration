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

  bool _speechEnalbled = false;
  String _wordSpoken = "";

  void startListening() async {
    // if (!_speechEnalbled) {
    //   return ;
    // }
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
      ),
      body: Column(
        children: [
          // Add the toolbox here
          QuillSimpleToolbar(
            controller: _controller,
          ),
          Cursordocument(
            controller: _controller,
          ),

          Buttons(
            startListening: startListening,
            stopListening: stopListening,
            speechToText: speechToText,
            save: _saveDocument,
          ),
          // Speech-to-Text Status Display
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              speechToText.isListening
                  ? "Listening..."
                  : _speechEnalbled
                      ? "Tap the microphone to start listening"
                      : "Speech not available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Display Recognized Speech
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Result: ",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Expanded(
                  child: Text(
                    _wordSpoken,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
