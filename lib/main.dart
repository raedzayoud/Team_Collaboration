import 'package:collab_doc/feature/authentication/data/repos/authentication_repo_impl.dart';
import 'package:collab_doc/feature/authentication/presentation/manager/cubit/authentication_cubit.dart';
import 'package:collab_doc/feature/authentication/presentation/view/login_view.dart';
import 'package:collab_doc/feature/document/data/repos/document_repos_impl.dart';
import 'package:collab_doc/feature/document/prenstation/manager/cubit/document_cubit.dart';
import 'package:collab_doc/feature/home/data/repos/home_repos_impl.dart';
import 'package:collab_doc/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:collab_doc/feature/home/presentation/view/home_screen_view.dart';
import 'package:collab_doc/core/utils/router.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo_impl.dart';
import 'package:collab_doc/feature/invitation/presentation/manager/cubit/invitation_cubit.dart';
import 'package:collab_doc/feature/meetings/data/repos/metting_repos_impl.dart';
import 'package:collab_doc/feature/meetings/presentation/manger/cubit/mettings_cubit.dart';
import 'package:collab_doc/feature/settings/data/repos/settings_repos_impl.dart';
import 'package:collab_doc/feature/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:collab_doc/feature/teams/data/repos/teams_repo_impl.dart';
import 'package:collab_doc/feature/teams/presentation/manager/cubit/team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill_localization;
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
late SharedPreferences infoUserSharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  infoUserSharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DocumentCubit(DocumentReposImpl())),
        BlocProvider(create: (context) => MettingsCubit(MettingReposImpl())),
        BlocProvider(
            create: (context) => AuthenticationCubit(AuthenticationRepoImpl())),
        BlocProvider(create: (context) => HomeCubit(HomeReposImpl())),
        BlocProvider(create: (context) => TeamCubit(TeamsRepoImpl())),
        BlocProvider(create: (context) => InvitationCubit(InvitationRepoImpl())),
        BlocProvider(
          create: (context) => SettingsCubit(SettingsReposImpl()),
        )
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          quill_localization
              .FlutterQuillLocalizations.delegate, // Add this line
        ],
        supportedLocales: [
          const Locale('en', 'US'), // Add the supported locales here
          const Locale('fr', 'FR'),
          // Add any other locales you want to support
        ],
        debugShowCheckedModeBanner: false,
        home: infoUserSharedPreferences.getString("token") == null
            ? LoginView()
            : HomeScreenView(),
        routes: AppRouter.pageRoutes,
      ),
    );
  }
}
