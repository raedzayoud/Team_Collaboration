import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_button.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/custombutton.dart';
import 'package:flutter/material.dart';

class ButtonsMettings extends StatelessWidget {
  const ButtonsMettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButtons(
          name: "New Mettings",
          onPressed: () {},
        ),
        SizedBox(
          width: 10,
        ),
        CustomButtons(
          name: "Join Mettings",
          onPressed: () {},
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
