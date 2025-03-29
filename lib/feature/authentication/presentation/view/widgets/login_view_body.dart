import 'package:collab_doc/feature/authentication/presentation/view/widgets/content_body_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    //String? errorMessage;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: content_body_login(
              formKey: formKey,
              email: email,
              password: password,
            ),
          ),
        ],
      ),
    );
  }
}
