import 'package:collab_doc/constant.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:flutter/material.dart';

class CardReponse extends StatelessWidget {
  const CardReponse({
    super.key,
    required this.invitation,
  });

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
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
                "Team ID: ${invitation.teamId}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "User ${invitation.userSenderId} invited you to join",
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
                    // Accept action — add logic here
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
                    // Reject action — add logic here
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
  }
}
