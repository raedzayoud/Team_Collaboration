import 'package:collab_doc/feature/authentication/presentation/view/widgets/content_body_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //if (errorMessage != null) CustomError(errorMessage: errorMessage!),
        Expanded(
          child: content_body_register(
            formKey: _formKey,
            email: email,
            username: username,
            password: password,
            phone: phone,
          ),
        ),
      ],
    );
  }
}
