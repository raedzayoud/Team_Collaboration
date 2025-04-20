import 'package:collab_doc/core/class/teammeber.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:flutter/material.dart';

Widget memberTile(UserDetails member, bool isOwner) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FA),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: Icon(Icons.person, color: Colors.black),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(member.username,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      isOwner ? 'Owner' : 'Member',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: member.active ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        member.active ? 'Online' : 'Offline',
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Icon(Icons.more_vert),
      ],
    ),
  );
}
