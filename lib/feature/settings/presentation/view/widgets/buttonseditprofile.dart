import 'package:collab_doc/constant.dart';
import 'package:collab_doc/feature/settings/presentation/manager/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsEditProfile extends StatelessWidget {
  final String username;
  const ButtonsEditProfile({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context); // Cancel goes back
          },
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.cancel, color: Colors.white),
              SizedBox(width: 8),
              Text("Cancel", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            BlocProvider.of<SettingsCubit>(context)
                .updateProfile(username: username);
           // Navigator.pop(context); // Save goes back
          },
          color: KPrimayColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.save, color: Colors.white),
              SizedBox(width: 8),
              Text("Save", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
