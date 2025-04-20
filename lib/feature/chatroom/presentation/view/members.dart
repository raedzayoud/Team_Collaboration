import 'package:collab_doc/feature/chatroom/presentation/view/widgets/cardmember.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:flutter/material.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/apparmemebers.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
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
        print("Team members loaded for: ${team!.name}");
      } else {
        print("No team provided!");
        Navigator.pop(context); // Safe fallback
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (team == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: ApparMemebers(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            cardmemebers(
              isOwner: true,
              name: team!.userOwner!.username,
              isConnected: team!.userOwner!.active,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: team!.members.length,
                itemBuilder: (context, index) {
                  final member = team!.members[index];

                  return cardmemebers(
                    isOwner: false,
                    name: member.username,
                    isConnected: member.active,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
