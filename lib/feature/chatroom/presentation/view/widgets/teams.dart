import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class teams extends StatelessWidget {
  final int id;
  final String? Teamname;
  const teams({
    super.key,
    required this.Teamname,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppResponsive.heigth(context) * .05),
      height: AppResponsive.heigth(context) * .2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: KPrimayColor,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Icon(
              Icons.group,
              color: KPrimayColor,
              size: 30,
            ),
          ),
          SizedBox(
            width: AppResponsive.width(context) * .02,
          ),
          Text(Teamname!,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
          Spacer(),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("chat",arguments: id);
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
