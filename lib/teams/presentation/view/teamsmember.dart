import 'package:flutter/material.dart';

class Teamsmember extends StatelessWidget {
  const Teamsmember({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Teams",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 2,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "My Teams"),
                  Tab(text: "Teams | Own"),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildTeamRow("Team 1", "8 members", "Member"),
                  Divider(),
                  _buildTeamRow("Team 2", "12 members", "Admin"),
                  Divider(),
                  _buildTeamRow("Team 3", "5 members", "Member"),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No Teams Found",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamRow(String teamName, String members, String role) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.group_outlined, color: Colors.black),
        ),
        SizedBox(width: 10),
        Expanded(
          child: ListTile(
            title: Text(teamName, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(members),
          ),
        ),
        Text(role, style: TextStyle(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
