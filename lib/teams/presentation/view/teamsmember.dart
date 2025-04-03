import 'package:collab_doc/teams/presentation/view/widgets/buildteamownrow.dart';
import 'package:collab_doc/teams/presentation/view/widgets/buildteamrow.dart';
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
                  Buildteamrow(
                      teamName: "Team 1", members: "8 members", role: "Member"),
                  Divider(),
                  Buildteamrow(
                      teamName: "Team 2", members: "8 members", role: "Admin"),
                  Divider(),
                  Buildteamrow(
                      teamName: "Team 3", members: "8 members", role: "Member"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  BuildteamOwnRow(
                      teamName: "Team 1", members: "8 members", role: "Owner"),
                  Divider(),
                  BuildteamOwnRow(
                      teamName: "Team 1", members: "8 members", role: "Owner"),
                  Divider(),
                  BuildteamOwnRow (
                      teamName: "Team 1", members: "8 members", role: "Owner"),
                  SizedBox(height: 10,),
                  MaterialButton(
                    padding: EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    color: Colors.black,
                    onPressed: (){},child: Text("Create New Team",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),)
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
