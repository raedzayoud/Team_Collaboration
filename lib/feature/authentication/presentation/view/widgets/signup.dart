import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil("register", (route) => false);
      },
      child: Text(
        "Don't have an account? Sign up",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ));
  }
}
