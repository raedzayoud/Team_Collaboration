import 'package:collab_doc/feature/home/presentation/view/home_screen_view.dart';
import 'package:collab_doc/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill_localization;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        quill_localization.FlutterQuillLocalizations.delegate, // Add this line
      ],
      supportedLocales: [
        const Locale('en', 'US'), // Add the supported locales here
        const Locale('fr', 'FR'),
        // Add any other locales you want to support
      ],
      debugShowCheckedModeBanner: false,
      home: HomeScreenView(),
      routes: AppRouter.pageRoutes,
    );
  }
}
