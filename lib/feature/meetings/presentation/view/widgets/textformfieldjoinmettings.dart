
import 'package:flutter/material.dart';

class TextFormFieldJoinMettings extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  const TextFormFieldJoinMettings({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
