import 'package:collab_doc/feature/chatroom/presentation/view/equipchat.dart';
import 'package:collab_doc/feature/home/presentation/view/home.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/bottomNavigatorHome.dart';
import 'package:collab_doc/feature/invitation/presentation/view/invitation.dart';
import 'package:collab_doc/feature/settings/presentation/view/settings.dart';
import 'package:collab_doc/feature/teams/presentation/view/teamsmember.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  int _page = 0;

  List<Widget> pages = [
    Home(),
    Invitation(),
    Equipchat(),
    Teamsmember(),
    Settings()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: Bottomnavigatorhome(
          page: _page,
          onTap: onPageChanged,
        ));
  }
}
