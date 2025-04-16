
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {
              infoUserSharedPreferences.clear();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "login", (route) => false);
            },
            child: Text("Logout")),
      ],
    );
  }
}
