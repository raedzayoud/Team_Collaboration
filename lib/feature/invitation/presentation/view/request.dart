import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/core/utils/function/successsnackbar.dart';
import 'package:collab_doc/core/utils/function/validator.dart';
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_text_field.dart';
import 'package:collab_doc/feature/invitation/presentation/manager/cubit/invitation_cubit.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/feature/teams/presentation/manager/cubit/team_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Team> allTeams = [];
  Team? selectedTeam;
  String selectedRole = "EDITEUR";
  final roles = ["EDITEUR", "LECTEUR"];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TeamCubit>(context).getAllMyTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: const Text(
          "Send Team Invitation",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocListener<TeamCubit, TeamState>(
        listener: (context, state) {
          if (state is MyTeamSuccess) {
            setState(() {
              allTeams = state.myteams;
            });
          } else if (state is MyTeamFailure) {
            snackbarerror(context, state.errorsMessage);
          }
        },
        child: BlocBuilder<TeamCubit, TeamState>(
          builder: (context, state) {
            if (state is MyTeamLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: allTeams.length,
                        itemBuilder: (context, index) {
                          final team = allTeams[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: Radio<Team>(
                                value: team,
                                groupValue: selectedTeam,
                                onChanged: (Team? value) {
                                  setState(() {
                                    selectedTeam = value;
                                  });
                                },
                                activeColor: KPrimayColor,
                              ),
                              title: Text(
                                team.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${team.members.length} members',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: DropdownButton<String>(
                        value: selectedRole,
                        hint: Text('Choisissez un rôle'),
                        items: roles.map((String role) {
                          return DropdownMenuItem<String>(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue != null) {
                              selectedRole = newValue;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: AppResponsive.heigth(context) * .03),
                    CustomTextField(
                      controller: controller,
                      hintText: "Enter the receiver's email",
                      suffixIcon: const Icon(Icons.email_outlined),
                      validator: (val) => validateEmail(val),
                      obscureText: false,
                      onChanged: (val) => setState(() {}),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BlocConsumer<InvitationCubit, InvitationState>(
        listener: (context, state) {
          if (state is InvitationSuccess) {
            snackbarsuccess(
              context,
              "Invitation sent to ${controller.text} for team '${selectedTeam!.name}'!",
            );
            controller.clear();
            setState(() {
              selectedTeam = null;
            });
          } else if (state is InvitationFailure) {
            snackbarerror(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          final isDisabled = (selectedTeam == null || controller.text.isEmpty);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: isDisabled
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<InvitationCubit>(context)
                            .sendInvitation(
                          controller.text,
                          selectedTeam!.id,
                          selectedRole
                        );
                      }
                    },
              icon: state is InvitationLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.send, color: Colors.white),
              label: Text(
                state is InvitationLoading ? "Sending..." : "Send Invitation",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: KPrimayColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          );
        },
      ),
    );
  }
}
