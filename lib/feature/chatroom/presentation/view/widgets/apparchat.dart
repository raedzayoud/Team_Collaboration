import 'package:collab_doc/constant.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:flutter/material.dart';

class Apparchat extends StatelessWidget implements PreferredSizeWidget {
  final Team team;
  const Apparchat(this.team, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("members", arguments: team);
            },
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ))
      ],
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
