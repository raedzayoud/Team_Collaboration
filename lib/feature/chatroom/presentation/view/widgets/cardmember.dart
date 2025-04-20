import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class cardmemebers extends StatelessWidget {
  const cardmemebers({
    super.key,
    required this.name,
    required this.isConnected,
    required this.isOwner,
  });
  final bool isOwner;
  final String name;
  final bool isConnected;

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: KPrimayColor,
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
                  color: isConnected == true ? notificationGreen : null,
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
            // color: KPrimayColor,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              isOwner ? Icons.shield : Icons.group,
              color: KPrimayColor,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(
              isOwner ? 'Owner' : 'Member',
              style: TextStyle(
                color: KPrimayColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: isOwner ? Icon(Icons.verified, color: KPrimayColor) : null,
      ),
    );
  }
}
