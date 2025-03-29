
import 'package:flutter/material.dart';

class Have_Account extends StatelessWidget {
  const Have_Account({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
       // Get.offAllNamed(AppRouter.login);
       Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
      },
      child: Text(
        "have an account?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ));
  }
}