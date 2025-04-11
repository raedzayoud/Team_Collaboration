import 'package:collab_doc/core/class/teammeber.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/apparteamdetails.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/membertile.dart';
import 'package:flutter/material.dart';

class Teamdetails extends StatelessWidget {
  Teamdetails({super.key});

  final List<TeamMember> members = [
    TeamMember(name: "Alex Johnson", isOnline: true, isAdmin: true),
    TeamMember(name: "Sarah Williams", isOnline: true, isAdmin: false),
    TeamMember(name: "Michael Brown", isOnline: false, isAdmin: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApparTeamDetails(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.group_outlined,
                color: Color.fromARGB(255, 228, 144, 18),
              ),
              title: Text(
                'Team Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              "Description: Our marketing team collaborates on campaigns, content creation, and brand strategy to drive business growth.",
            ),
            const SizedBox(height: 10),
            const Text(
              "All Members",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // List of team members
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                return memberTile(members[index]);
              },
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "All Documents",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
