import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/appareditprofile.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/buttonseditprofile.dart';
import 'package:collab_doc/feature/settings/presentation/view/widgets/textformfieldedit.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final TextEditingController _usernameController = TextEditingController();
  @override
  void initState() {
    _usernameController.text =
        infoUserSharedPreferences.getString("username").toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApparEditProfile(),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsSuccess) {
            Navigator.pop(context);
          }
          if (state is SettingsFailure) {
            snackbarerror(context, state.message);
          }
        },
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if(state is SettingsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextfieldEditProfile(
                    controller: _usernameController,
                    labelText: "username",
                    prefixIcon: Icon(Icons.person),
                  ),
                  const Spacer(),
                  ButtonsEditProfile(
                    username: _usernameController.text,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
