import 'package:collab_doc/feature/authentication/presentation/view/login_view.dart';
import 'package:collab_doc/feature/authentication/presentation/view/register_view.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/chatroom.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/members.dart';
import 'package:collab_doc/feature/home/presentation/view/home_screen_view.dart';
import 'package:collab_doc/feature/invitation/presentation/view/pending.dart';
import 'package:collab_doc/feature/invitation/presentation/view/request.dart';
import 'package:collab_doc/feature/invitation/presentation/view/responses.dart';
import 'package:collab_doc/feature/meetings/presentation/view/joinmettings.dart';
import 'package:collab_doc/feature/settings/presentation/view/edit.dart';
import 'package:collab_doc/feature/teams/presentation/view/newteam.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> pageRoutes = {
    "register": (context) => const RegisterView(),
    "login": (context) => const LoginView(),
    "home": (context) => const HomeScreenView(),
    "chat": (context) => const Chatroom(),
    "newteam": (context) => const Newteam(),
    "members": (context) => const Members(),
    "edit": (context) => const Edit(),
    "joinmettings":(context) => const Joinmettings(),
    "request":(context) => const Request(),
    "pending":(context) => const Pending(),
    "response":(context) => const Responses(),
    //"addDocument":(context)=>AddDocumentPage(),
  };
}
