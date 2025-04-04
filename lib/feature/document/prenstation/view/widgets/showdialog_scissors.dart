import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

Future<void> showDialogScissors({
  required BuildContext context,
  required TextEditingController textEditingController,
  required quill.QuillController controller,
  required VoidCallback onPressed,
}) {
  textEditingController.text = controller.document.toPlainText();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Resume Text Summarizer",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: TextFormField(
        readOnly: true,
        controller: textEditingController,
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
          onPressed: () => Navigator.of(context).pop(),
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
          onPressed: onPressed,
          child: Text("Apply Resume",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    ),
  );
}
