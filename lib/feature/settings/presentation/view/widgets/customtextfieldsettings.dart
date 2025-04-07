import 'package:flutter/material.dart';

class CustomTextformFieldSettings extends StatelessWidget {
  final TextEditingController? controller;
  const CustomTextformFieldSettings({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      //initialValue: initialValue ?? '',
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
