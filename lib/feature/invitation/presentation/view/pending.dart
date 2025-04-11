import 'package:collab_doc/feature/invitation/presentation/view/widgets/accpetedtab.dart';
import 'package:collab_doc/feature/invitation/presentation/view/widgets/apparpending.dart';
import 'package:collab_doc/feature/invitation/presentation/view/widgets/pendingtab.dart';
import 'package:collab_doc/feature/invitation/presentation/view/widgets/rejectedtab.dart';
import 'package:flutter/material.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final List<Map<String, dynamic>> invitations = [
    {
      'team': 'Design Masters',
      'isYourTeam': true,
      'status': 'Pending',
      'sentAgo': '',
    },
    {
      'team': 'Development Team',
      'isYourTeam': false,
      'status': 'Pending',
      'sentAgo': '2 days ago',
      'waiting': true,
      'daysLeft': 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:ApparPending() ,
        body: TabBarView(
          children: [
            PendingTab(invitations: invitations),
            AcceptedTab(invitations: invitations),
            RejectedTab(invitations: invitations),
          ],
        ),
      ),
    );
  }
}

