import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class ApparTeamDetails extends StatelessWidget implements PreferredSizeWidget {
  const ApparTeamDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KPrimayColor,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: const Text(
        'Team Details',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(80, 60);
}
