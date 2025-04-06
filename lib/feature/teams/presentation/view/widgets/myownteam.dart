
import 'package:collab_doc/feature/teams/presentation/view/widgets/buildteamownrow.dart';
import 'package:flutter/material.dart';

class MyOwnTeam extends StatelessWidget {
  const MyOwnTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [
          BuildteamOwnRow(
              teamName: "Team 1", members: "8 members", role: "Owner"),
          Divider(),
          BuildteamOwnRow(
              teamName: "Team 1", members: "8 members", role: "Owner"),
          Divider(),
          BuildteamOwnRow(
              teamName: "Team 1", members: "8 members", role: "Owner"),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            padding: EdgeInsets.all(14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pushNamed("newteam");
            },
            child: Text(
              "Create New Team",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
