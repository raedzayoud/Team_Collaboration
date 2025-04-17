import 'package:flutter/material.dart';

void snackbarsuccess(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating, // Set behavior to floating
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      ),
    );
  }