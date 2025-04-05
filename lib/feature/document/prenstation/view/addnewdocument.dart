import 'package:collab_doc/core/widgets/custom_error.dart';
import 'package:collab_doc/core/widgets/custom_loading.dart';
import 'package:collab_doc/feature/document/prenstation/manager/cubit/document_cubit.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/apparaddnewdocument.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/buttons.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/cursordocument.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/showdialog_scissors.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  quill.QuillController _controller = quill.QuillController.basic();
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
    init2();
  }

  void init2() {
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
      appBar: ApparAddNewDocument(
          textEditingController: _textEditingController,
          controller: _controller),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
          ),
          BlocListener<DocumentCubit, DocumentState>(
            listener: (context, state) {
              if (state is DocumentSuccess) {
                _controller = quill.QuillController(
                  document: quill.Document()..insert(0, state.summary),
                  selection: const TextSelection.collapsed(offset: 0),
                );
              }
              if (state is DocumentInitial) {
                _controller = quill.QuillController.basic();
              }
            },
            child: BlocBuilder<DocumentCubit, DocumentState>(
              builder: (context, state) {
                if (state is DocumentLoading) {
                  return CustomLoading();
                } else if (state is DocumentFailure) {
                  return CustomError(errorMessage: state.errorMessage);
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Cursordocument(
                        controller: _controller,
                      ),
                    ),
                  );
                }
              },
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
