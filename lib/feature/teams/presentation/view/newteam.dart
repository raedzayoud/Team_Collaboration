import 'dart:ui';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/core/utils/function/successsnackbar.dart';
import 'package:collab_doc/core/utils/function/validator.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_text_field.dart';
import 'package:collab_doc/feature/teams/presentation/manager/cubit/team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Newteam extends StatefulWidget {
  const Newteam({super.key});

  @override
  State<Newteam> createState() => _NewteamState();
}

class _NewteamState extends State<Newteam> {
  TextEditingController teamNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nbreController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    teamNameController.dispose();
    descriptionController.dispose();
    nbreController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin:
                  EdgeInsets.only(right: AppResponsive.width(context) * .06),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.group,
                  color: Color.fromARGB(255, 231, 153, 35)),
            ),
            const Text(
              "Create New Team",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: BlocListener<TeamCubit, TeamState>(
        listener: (context, state) async {
          if (state is TeamSuccess) {
            snackbarsuccess(context, "Team created successfully!");
            teamNameController.clear();
            descriptionController.clear();
            nbreController.clear();
            await BlocProvider.of<TeamCubit>(context).getAllMyTeam();
            // Navigator.pop(context);
          } else if (state is TeamFailure) {
            snackbarerror(context, state.errorsMessage);
          }
        },
        child: BlocBuilder<TeamCubit, TeamState>(
          builder: (context, state) {
            if (state is TeamLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Team Name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    CustomTextField(
                      controller: teamNameController,
                      hintText: "Team Name",
                      obscureText: false,
                      suffixIcon: Icon(Icons.group_sharp),
                      validator: (val) {
                        return validateTeamName(val);
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: "Description",
                      obscureText: false,
                      suffixIcon: Icon(Icons.group_sharp),
                      validator: (val) {
                        return validateDescription(val);
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Nbre of members",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: nbreController,
                      hintText: "nbre of members",
                      obscureText: false,
                      suffixIcon: Icon(Icons.group_sharp),
                      validator: (val) {
                        return validateNbre(val);
                      },
                    ),
                    const SizedBox(height: 16),
                    Spacer(),
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minWidth: double.infinity,
                        color: Colors.black,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<TeamCubit>(context).AddNewTeam(
                                teamNameController.text,
                                descriptionController.text,
                                nbreController.text);
                          }
                        },
                        child: Text(
                          "Create Team",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
