import 'package:collab_doc/feature/authentication/presentation/view/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginViewBody(),
    );
  }
}