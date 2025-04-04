
import 'package:flutter/material.dart';

class BuildteamOwnRow extends StatelessWidget {
  final String teamName;
  final String members;
  final String role;

  const BuildteamOwnRow({
    super.key,
    required this.teamName,
    required this.members,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.groups,
              color: const Color.fromARGB(255, 209, 142, 41)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ListTile(
              title:
                  Text(teamName, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(members)),
        ),
        Container(
            width: 70,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              role,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }
}
