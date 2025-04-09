import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allTeams = ['Development Team', 'Marketing Team', 'Design Team'];
  List<String> filteredTeams = [];
  Set<String> selectedTeams = {};
  void _filterTeams(String query) {
    setState(() {
      filteredTeams = allTeams
          .where((team) => team.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    filteredTeams = allTeams;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: const Text(
          "Send Team Invitation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: _filterTeams,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for teams...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTeams.length,
                itemBuilder: (context, index) {
                  String team = filteredTeams[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Checkbox(
                        value: selectedTeams.contains(team),
                        onChanged: (_) {
                          setState(() {
                            if (selectedTeams.contains(team)) {
                              selectedTeams.remove(team);
                            } else {
                              selectedTeams.add(team);
                            }
                          });
                        },
                      ),
                      title: Text(team,style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text(team == 'Development Team'
                          ? '12 members'
                          : '9 members',style: TextStyle(
                            fontWeight: FontWeight.w300
                          ),),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () {
            // Handle send logic
          },
          icon: Icon(
            Icons.send,
            color: Colors.white,
          ),
          label: Text(
            "Send Invitations",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: KPrimayColor,
            minimumSize: Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    );
  }
}
