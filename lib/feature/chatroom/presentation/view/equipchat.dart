import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/chatroom/presentation/manager/cubit/chatroom_cubit.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/teams.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Equipchat extends StatefulWidget {
  const Equipchat({super.key});

  @override
  State<Equipchat> createState() => _EquipchatState();
}

class _EquipchatState extends State<Equipchat> {
  List<Team> team = [];
  @override
  void initState() {
    context.read<ChatroomCubit>().getAllTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: Text(
          "Chat Teams",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<ChatroomCubit, ChatroomState>(
        listener: (context, state) {
          if (state is ChatroomSuccess) {
            setState(() {
              team = state.teams;
            });
          } else if (state is ChatroomFailure) {
            snackbarerror(context, state.errorMessage);
          }
        },
        child: BlocBuilder<ChatroomCubit, ChatroomState>(
          builder: (context, state) {
            if (state is ChatroomLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.only(
                    top: AppResponsive.heigth(context) * .02,
                    left: AppResponsive.width(context) * .02,
                    right: AppResponsive.width(context) * .02),
                itemCount: team.length,
                itemBuilder: (context, index) {
                  return TeamWidget(
                    team: team[index],
                  );
                });
          },
        ),
      ),
    );
  }
}
