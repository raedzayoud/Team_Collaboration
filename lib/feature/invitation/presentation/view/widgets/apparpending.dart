
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class ApparPending extends StatelessWidget implements PreferredSizeWidget {
  const ApparPending({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          centerTitle: true,
          backgroundColor: KPrimayColor,
          title: Text("Sent Invitations", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Accepted"),
              Tab(text: "Rejected"),
            ],
          ),
        );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(80, 80);
}
