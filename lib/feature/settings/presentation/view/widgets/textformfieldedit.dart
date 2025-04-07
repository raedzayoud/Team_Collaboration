
import 'package:flutter/material.dart';

class TextfieldEditProfile extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? labelText;
  const TextfieldEditProfile(
      {super.key,
      required this.controller,
      required this.labelText,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
