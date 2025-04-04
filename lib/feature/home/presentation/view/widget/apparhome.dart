
import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/assets.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class ApparHome extends StatelessWidget {
  const ApparHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: KPrimayColor,
      height: AppResponsive.heigth(context) * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            AssetsImage.home_document,
          ),
          Expanded(
              child: Text(
            "Modify your document in \n real time with your team",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w500),
          )),
        ],
      ),
    );
  }
}
