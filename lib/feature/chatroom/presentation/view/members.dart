import 'package:collab_doc/feature/chatroom/presentation/view/widgets/cardmember.dart';
import 'package:flutter/material.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/apparmemebers.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> members = [
      {'name': 'John Doe', 'role': 'owner', 'isconnected': true},
      {'name': 'Jane Smith', 'role': 'member', 'isconnected': false},
      {'name': 'Alice Johnson', 'role': 'member', 'isconnected': true},
      {'name': 'Bob Brown', 'role': 'admin', 'isconnected': false},
    ];
    return Scaffold(
      appBar: ApparMemebers(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final name = members[index]['name'];
            final role = members[index]['role'];
            final isConnected = members[index]['isconnected'];
            final isOwner = role == 'owner';
            final isAdmin = role == 'admin';

            return cardmemebers(
              isOwner: isOwner,
              isAdmin: isAdmin,
              name: name,
              isConnected: isConnected,
            );
          },
        ),
      ),
    );
  }
}
