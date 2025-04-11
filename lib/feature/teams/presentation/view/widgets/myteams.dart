import 'package:collab_doc/feature/teams/presentation/view/widgets/buildteamrow.dart';
import 'package:flutter/material.dart';

class MyTeams extends StatelessWidget {
  const MyTeams({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, 'teamdetails'),
            child: Buildteamrow(
                teamName: "Team 1", members: "8 members", role: "Member"),
          ),
          Divider(),
          Buildteamrow(teamName: "Team 2", members: "8 members", role: "Admin"),
          Divider(),
          Buildteamrow(
              teamName: "Team 3", members: "8 members", role: "Member"),
        ],
      ),
    );
  }
}
