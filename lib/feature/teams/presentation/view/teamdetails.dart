import 'package:collab_doc/core/class/teammeber.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/apparteamdetails.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/membertile.dart';
import 'package:flutter/material.dart';

class Teamdetails extends StatefulWidget {
  Teamdetails({super.key});

  @override
  State<Teamdetails> createState() => _TeamdetailsState();
}

class _TeamdetailsState extends State<Teamdetails> {
  Team? team;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Team?;
      if (arguments != null) {
        setState(() {
          team = arguments;
        });
        print(
            "Chat opened for team----------------------------------: ${team!.name}");
      } else {
        print("No team provided!");
        Navigator.pop(context); // Go back safely if no team is passed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (team == null) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }
    return Scaffold(
      appBar: ApparTeamDetails(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                Icons.group_outlined,
                color: Color.fromARGB(255, 228, 144, 18),
              ),
              title: Text(
                '${team!.name} (${team!.members.length} Members)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Description: ${team!.description}.",
            ),
            const SizedBox(height: 10),
            const Text(
              "Owner",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (team!.userOwner != null) memberTile(team!.userOwner!, true),
            SizedBox(
              height: 10,
            ),
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
              itemCount: team!.members.length,
              itemBuilder: (context, index) {
                return memberTile(team!.members[index], false);
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
