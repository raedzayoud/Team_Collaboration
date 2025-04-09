import 'package:collab_doc/constant.dart';
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: KPrimayColor,
          title: Text(
            "Sent Invitations",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          // actions: [
          //   Icon(Icons.refresh),
          //   SizedBox(width: 16),
          //   Icon(Icons.filter_list),
          //   SizedBox(width: 16),
          // ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Accepted"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: TabBarView(children: [
          Column(
            children: [
              // Status Summary
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Invitation Status",
                            style: TextStyle(fontSize: 16)),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("3 Pending"),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              // Invitations List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: invitations.length,
                  itemBuilder: (context, index) {
                    final item = invitations[index];
                    return Card(
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
                                    child: Icon(
                                      Icons.group,
                                      color: Colors.black,
                                    ),
                                    radius: 20,
                                    backgroundColor: Colors.grey[300]),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['team'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    if (item['isYourTeam'] == true)
                                      Text("Your team",
                                          style: TextStyle(color: Colors.grey)),
                                    if (item['sentAgo'] != '')
                                      Text("Sent ${item['sentAgo']}",
                                          style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.more_vert),
                              ],
                            ),
                            if (item['waiting'] == true)
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  children: [
                                    Chip(
                                      label: Text("Waiting for response"),
                                      backgroundColor: Colors.grey[100],
                                    ),
                                    SizedBox(width: 8),
                                    Chip(
                                      label:
                                          Text("${item['daysLeft']} days left"),
                                      backgroundColor: Colors.grey[100],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Bottom Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Send Reminder to All",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: KPrimayColor,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text("Accepted"),
          ),
          Center(
            child: Text("Rejected"),
          ),
        ]),
      ),
    );
  }
}
