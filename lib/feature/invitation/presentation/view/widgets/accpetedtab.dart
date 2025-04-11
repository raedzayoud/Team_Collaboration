import 'package:flutter/material.dart';

class AcceptedTab extends StatelessWidget {
  final List<Map<String, dynamic>> invitations;
  const AcceptedTab({required this.invitations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Invitation Status", style: TextStyle(fontSize: 16)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("Accepted"),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: invitations.length,
            itemBuilder: (context, index) {
              final item = invitations[index];
              return item['isYourTeam'] == false
                  ? Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    child: Icon(Icons.group, color: Colors.black),
                                    radius: 20,
                                    backgroundColor: Colors.grey[300]),
                                SizedBox(width: 10),
                                Text(item['team'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Spacer(),
                                Icon(Icons.more_vert),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                children: [
                                  Chip(
                                    label: Text("Accepted"),
                                    backgroundColor: Colors.grey[100],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
            },
          ),
        ),
      ],
    );
  }
}
