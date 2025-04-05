
import 'package:collab_doc/feature/document/prenstation/manager/cubit/document_cubit.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/showdialog_scissors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ApparAddNewDocument extends StatelessWidget
    implements PreferredSizeWidget {
  const ApparAddNewDocument({
    super.key,
    required TextEditingController textEditingController,
    required QuillController controller,
  })  : _textEditingController = textEditingController,
        _controller = controller;

  final TextEditingController _textEditingController;
  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("New Document"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.content_cut_outlined),
          onPressed: () {
            showDialogScissors(
              context: context,
              textEditingController: _textEditingController,
              controller: _controller,
              onPressed: () {
                if (_controller.document.toPlainText().trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter text to summarize."),
                    ),
                  );
                  Navigator.of(context).pop();
                  return;
                }
                BlocProvider.of<DocumentCubit>(context).summarizeText(
                  _controller.document.toPlainText(),
                );
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ],
    );
  }

 @override
Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
