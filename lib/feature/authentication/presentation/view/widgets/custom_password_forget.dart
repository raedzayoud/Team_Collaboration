import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class CustomPasswordForget extends StatelessWidget {
  const CustomPasswordForget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        InkWell(
          onTap: () {
           // Get.toNamed(AppRouter.forgerpassword);
          },
          child: const Text(
            "Forgot Password?",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: KPrimayColor),
          ),
        ),
      ],
    );
  }
}