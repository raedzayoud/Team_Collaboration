import 'package:collab_doc/feature/home/presentation/view/home_screen_view.dart';
import 'package:collab_doc/utils/router.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: HomeScreenView(),
      routes: AppRouter.pageRoutes,
    );
  }
}