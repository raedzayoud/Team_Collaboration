import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/invitation/presentation/view/widgets/invitations.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/feature/teams/presentation/manager/cubit/team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Invitation extends StatelessWidget {
  const Invitation({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> team = [
      "Invitations Request",
      
      "Invitations Response"
    ];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: KPrimayColor,
          title: Text(
            "Invitation Teams",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            padding: EdgeInsets.only(
                top: AppResponsive.heigth(context) * .02,
                left: AppResponsive.width(context) * .02,
                right: AppResponsive.width(context) * .02),
            itemCount: team.length,
            itemBuilder: (context, index) {
              return invitations(
                team: team,
                index: index,
              );
            }));
  }
}
