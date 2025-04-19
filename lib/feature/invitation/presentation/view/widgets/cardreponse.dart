import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/core/utils/function/successsnackbar.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:collab_doc/feature/invitation/presentation/manager/cubit/invitation_cubit.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardReponse extends StatefulWidget {
  const CardReponse({
    super.key,
    required this.invitation,
  });

  final InvitationModel invitation;

  @override
  State<CardReponse> createState() => _CardReponseState();
}

class _CardReponseState extends State<CardReponse> {
  Team? teamDetails;
  UserDetails? userDetails;
  @override
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    teamDetails = await BlocProvider.of<InvitationCubit>(context)
        .getTeamDetailsById(widget.invitation.teamId!);

    userDetails = await BlocProvider.of<InvitationCubit>(context)
        .getUserDetailsById(widget.invitation.userSenderId!);

    setState(() {}); // to rebuild with loaded data
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: KPrimayColor.withOpacity(0.2),
                child: Icon(Icons.group, color: KPrimayColor),
              ),
              title: Text(
                "Team: ${teamDetails?.name}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "Owner ${userDetails?.username} invited you to join",
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(Icons.more_vert),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    BlocProvider.of<InvitationCubit>(context)
                        .acceptInvitation(widget.invitation.id!);
                    snackbarsuccess(
                      context,
                      "Invitation accepted successfully.",
                    );
                  },
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  label: const Text("Accept"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    BlocProvider.of<InvitationCubit>(context)
                        .rejectInvitation(widget.invitation.id!);
                    snackbarerror(context, "Invitation rejected successfully");
                  },
                  icon: const Icon(Icons.cancel, color: Colors.white),
                  label: const Text("Reject"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(120, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
