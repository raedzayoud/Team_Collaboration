import 'package:collab_doc/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';

void snackbarerror(BuildContext context, String errorMessage) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        behavior: SnackBarBehavior.floating, // Set behavior to floating
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      ),
    );
  }