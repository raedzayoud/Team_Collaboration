
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class ApparMemebers extends StatelessWidget implements PreferredSizeWidget {
  const ApparMemebers({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Memebers",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: KPrimayColor,
      );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
