import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class Cursordocument extends StatelessWidget {
  final quill.QuillController controller;
  const Cursordocument({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    final ScrollController _scrollController = ScrollController();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: quill.QuillEditor(
          controller: controller,
          focusNode: _focusNode,
          scrollController: _scrollController,
          config: quill.QuillEditorConfig(
            readOnlyMouseCursor: SystemMouseCursors.basic,
          ),
        ),
      ),
    );
  }
}
