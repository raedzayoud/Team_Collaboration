import 'package:collab_doc/constant.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/teams.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class Equipchat extends StatelessWidget {
  const Equipchat({super.key});

  @override
  Widget build(BuildContext context) {
    Map<int,String>team={1:"Raed Team",2:"Houssaine Team"};
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: Text(
          "Chat Teams",
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
            int id=team.keys.elementAt(index);
            return teams(Teamname: team[id],id:id ,);
          }),
    );
  }
}
