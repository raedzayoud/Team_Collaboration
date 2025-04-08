import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_button.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/custombutton.dart';
import 'package:collab_doc/feature/meetings/presentation/manger/cubit/mettings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsMettings extends StatelessWidget {
  const ButtonsMettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButtons(
          name: "New Mettings",
          onPressed: () {
            BlocProvider.of<MettingsCubit>(context).createMeeting();
          },
        ),
        SizedBox(
          width: 10,
        ),
        CustomButtons(
          name: "Join Mettings",
          onPressed: () {
            Navigator.of(context).pushNamed("joinmettings");
          },
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
