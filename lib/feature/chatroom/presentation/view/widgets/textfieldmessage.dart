
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class TextFieldMessage extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onPressed;
  const TextFieldMessage({super.key, required this.controller, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type your message here...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: KPrimayColor, width: 2),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.send,
                color: KPrimayColor,
              )),
        ],
      ),
    );
  }
}
