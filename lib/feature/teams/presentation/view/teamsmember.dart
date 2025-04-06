import 'package:collab_doc/feature/teams/presentation/view/widgets/apparteams.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/myownteam.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/myteams.dart';
import 'package:flutter/material.dart';

class Teamsmember extends StatelessWidget {
  const Teamsmember({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ApparTeams(),
        body: TabBarView(
          children: [
            MyTeams(),
            MyOwnTeam(),
          ],
        ),
      ),
    );
  }
}
