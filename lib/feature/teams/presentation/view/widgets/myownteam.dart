import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/teams/presentation/manager/cubit/team_cubit.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/buildteamownrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOwnTeam extends StatefulWidget {
  const MyOwnTeam({super.key});

  @override
  State<MyOwnTeam> createState() => _MyOwnTeamState();
}

class _MyOwnTeamState extends State<MyOwnTeam> {
  List MyteamList = [];
  @override
  void initState() {
    BlocProvider.of<TeamCubit>(context).getAllMyTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: BlocListener<TeamCubit, TeamState>(
        listener: (context, state) {
          if (state is MyTeamSuccess) {
            MyteamList = state.myteams;
          } else if (state is MyTeamFailure) {
            snackbarerror(context, state.errorsMessage);
          }
        },
        child: BlocBuilder<TeamCubit, TeamState>(
          builder: (context, state) {
            if (state is MyTeamLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                if (MyteamList.isEmpty)
                  Center(
                    child: Text(
                      "No teams found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (MyteamList.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: MyteamList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'teamdetails',
                                arguments: MyteamList[index]);
                          },
                          child: Column(
                            children: [
                              BuildteamOwnRow(
                                teamName: MyteamList[index].name,
                                role: "Owner",
                                members:
                                    MyteamList[index].members.length.toString(),
                              ),
                              Divider(),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                //Spacer(),
                MaterialButton(
                  minWidth: double.infinity,
                  padding: EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pushNamed("newteam");
                  },
                  child: Text(
                    "Create New Team",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
