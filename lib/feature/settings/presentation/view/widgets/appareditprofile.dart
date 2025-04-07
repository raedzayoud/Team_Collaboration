
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class ApparEditProfile extends StatelessWidget implements PreferredSizeWidget {
  const ApparEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context); // Go back to the previous screen
        },
      ),
      title: const Text(
        'Edit Profile',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: KPrimayColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
