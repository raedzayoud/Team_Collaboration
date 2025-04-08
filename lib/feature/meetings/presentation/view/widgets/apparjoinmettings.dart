
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class ApparJoinMettings extends StatelessWidget implements PreferredSizeWidget {
  const ApparJoinMettings();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
  }
}
