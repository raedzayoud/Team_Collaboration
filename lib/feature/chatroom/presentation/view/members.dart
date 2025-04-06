import 'package:collab_doc/feature/chatroom/presentation/view/widgets/cardmember.dart';
import 'package:flutter/material.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/apparmemebers.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, String> members = {
      "Yassine": "owner",
      "Raed": "admin",
      "Houssaine": "admin",
      "Ali": "member",
      "Sara": "member",
      "Omar": "member",
    };

    return Scaffold(
      appBar: ApparMemebers(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final name = members.keys.elementAt(index);
            final role = members.values.elementAt(index);
            final isAdmin = role == 'admin';

            return cardmemebers(isAdmin: isAdmin, name: name);
          },
        ),
      ),
    );
  }
}
