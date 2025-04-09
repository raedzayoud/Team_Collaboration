import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class Responses extends StatelessWidget {
  const Responses({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> ownTeams = [
      {'team': 'Design Masters', 'personSentToMe': 'Raed'},
      {'team': 'Development Team', 'personSentToMe': 'Mohammed'},
      {'team': 'Marketing Team', 'personSentToMe': 'Akram'},
      {'team': 'Design Team', 'personSentToMe': 'Ahmed'}
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: const Text(
          "Invitations Responses",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ownTeams.length,
        itemBuilder: (context, index) {
          final team = ownTeams[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor: KPrimayColor.withOpacity(0.2),
                      child: Icon(Icons.group, color: KPrimayColor),
                    ),
                    title: Text(
                      team['team'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "${team['personSentToMe']} wanted to join your team",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.more_vert),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Accept action
                        },
                        icon: const Icon(Icons.check_circle, color: Colors.white),
                        label: const Text("Accept"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Reject action
                        },
                        icon: const Icon(Icons.cancel, color: Colors.white),
                        label: const Text("Reject"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(120, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
