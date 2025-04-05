import 'package:collab_doc/feature/authentication/presentation/view/login_view.dart';
import 'package:collab_doc/feature/authentication/presentation/view/register_view.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/chatroom.dart';
import 'package:collab_doc/feature/home/presentation/view/home_screen_view.dart';
import 'package:collab_doc/feature/teams/presentation/view/newteam.dart';
import 'package:flutter/material.dart';

class AppRouter{
  static Map<String,Widget Function(BuildContext)>pageRoutes={
   "register":(context)=>const RegisterView(),
   "login":(context)=>const LoginView(),
   "home":(context)=>const HomeScreenView(),
   "chat":(context)=>const Chatroom(),
   "newteam":(context)=>const Newteam(),
   //"addDocument":(context)=>AddDocumentPage(),
  };
}