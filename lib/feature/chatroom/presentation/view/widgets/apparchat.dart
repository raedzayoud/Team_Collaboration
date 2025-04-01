
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class Apparchat extends StatelessWidget implements PreferredSizeWidget {
  const Apparchat();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
      backgroundColor: KPrimayColor,
      centerTitle: true,
      title: Text(
        "Chat Room",
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
