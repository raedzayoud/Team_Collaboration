import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/feature/teams/presentation/manager/cubit/team_cubit.dart';
import 'package:collab_doc/feature/teams/presentation/view/widgets/buildteamrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTeams extends StatefulWidget {
  const MyTeams({super.key});

  @override
  State<MyTeams> createState() => _MyTeamsState();
}

class _MyTeamsState extends State<MyTeams> {
  List<Team> teamsAsMemeber = [];

  @override
  void initState() {
    super.initState();
    // fetch the teams initially
    context.read<TeamCubit>().getAllMyTeamAsmemeber();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamCubit, TeamState>(
      listener: (context, state) {
        if (state is MyTeamFailure) {
          snackbarerror(context, state.errorsMessage);
        } else if (state is MyTeamSuccess) {
          setState(() {
            teamsAsMemeber = state.myteams;
          });
        }
      },
      child: BlocBuilder<TeamCubit, TeamState>(
        builder: (context, state) {
          if (state is MyTeamLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (teamsAsMemeber.isEmpty) {
            return const Center(
              child: Text("You are not a member of any teams."),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: teamsAsMemeber.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final team = teamsAsMemeber[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'teamdetails',
                        arguments: team);
                  },
                  child: Buildteamrow(
                    teamName: team.name,
                    members: "${team.members.length} members",
                    role: "Member"
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
