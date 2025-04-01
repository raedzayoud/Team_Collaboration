
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ButtonsMettings extends StatelessWidget {
  const ButtonsMettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(text: "New Mettings",
          onPressed: () {},
        ),
        SizedBox(
          width: 10,
        ),
        CustomButton(
          text: "Join Mettings",
          onPressed: () {},
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
