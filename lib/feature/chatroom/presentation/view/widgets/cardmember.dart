import 'package:flutter/material.dart';

class cardmemebers extends StatelessWidget {
  const cardmemebers({
    super.key,
    required this.isAdmin,
    required this.name,
  });

  final bool isAdmin;
  final String name;

  @override
  Widget build(BuildContext context) {
    final Color darkBlack = Colors.black;
    final Color darkGrey = Colors.black87;
    final Color notificationGreen = Colors.greenAccent.shade400;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: darkBlack,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notificationGreen,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: darkBlack,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              isAdmin ? Icons.shield : Icons.group,
              color: darkGrey,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              isAdmin ? 'Admin' : 'Member',
              style: TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: isAdmin
            ? Icon(Icons.verified, color: darkBlack)
            : null,
      ),
    );
  }
}
