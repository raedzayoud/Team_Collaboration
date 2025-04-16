import 'package:collab_doc/feature/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsSettings extends StatelessWidget {
  const ButtonsSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('edit');
            },
            child: Text("Edit")),
        MaterialButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () async {
              await BlocProvider.of<SettingsCubit>(context)
                  .updateStatustoInActive();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
               infoUserSharedPreferences.clear();
            },
            child: Text("Logout")),
      ],
    );
  }
}
