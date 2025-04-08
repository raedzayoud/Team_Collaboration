import 'package:collab_doc/constant.dart';
import 'package:collab_doc/feature/meetings/data/repos/metting_repos_impl.dart';
import 'package:collab_doc/feature/meetings/presentation/manger/cubit/mettings_cubit.dart';
import 'package:collab_doc/feature/meetings/presentation/view/widgets/apparjoinmettings.dart';
import 'package:collab_doc/feature/meetings/presentation/view/widgets/textformfieldjoinmettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Joinmettings extends StatefulWidget {
  const Joinmettings({super.key});

  @override
  State<Joinmettings> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<Joinmettings> {
  // bool audioSelected = true;
  // bool videoSelected = true;
  // // final AuthRepositoryImplementation authRepositoryImplementation =
  //     AuthRepositoryImplementation();
  late final TextEditingController idController;
  late final TextEditingController nameController;
  final MettingReposImpl meetingRepositoryImplementation = MettingReposImpl();

  @override
  void initState() {
    idController = TextEditingController();
    // nameController = TextEditingController(
    //     text: authRepositoryImplementation.user.displayName);
    nameController = TextEditingController(text: "raed");

    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApparJoinMettings(),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextFormFieldJoinMettings(
            controller: idController,
            hintText: 'Mettings ID',
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormFieldJoinMettings(
            controller: nameController,
            hintText: 'Name',
          ),
          const SizedBox(
            height: 25.0,
          ),
          SizedBox(
            height: 50,
            width: 350,
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(KPrimayColor),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(13),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                BlocProvider.of<MettingsCubit>(context)
                    .joinMeeting(idController.text);
              },
              child: const Center(
                child: Text(
                  'Join',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
