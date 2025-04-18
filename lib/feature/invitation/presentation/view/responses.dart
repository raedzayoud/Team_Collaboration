import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/utils/function/successsnackbar.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:collab_doc/feature/invitation/presentation/manager/cubit/invitation_cubit.dart';
import 'package:collab_doc/feature/invitation/presentation/view/widgets/cardreponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Responses extends StatefulWidget {
  const Responses({super.key});

  @override
  State<Responses> createState() => _ResponsesState();
}

class _ResponsesState extends State<Responses> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<InvitationCubit>(context).myInvitationIrecived();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KPrimayColor,
        title: const Text(
          "Invitations Responses",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: BlocConsumer<InvitationCubit, InvitationState>(
        listener: (context, state) {
          if (state is InvitationFailure) {
            snackbarsuccess(
                context, state.errorMessage ?? 'An error occurred.');
          }
        },
        builder: (context, state) {
          if (state is InvitationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InvitationSuccess) {
            final invitations = state.invitations ?? [];
            if (invitations.isEmpty) {
              return const Center(
                child: Text("No invitations received."),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: invitations.length,
              itemBuilder: (context, index) {
                if (invitations[index].status == "PENDING") {
                  return CardReponse(invitation: invitations[index]);
                } else {
                  return const SizedBox
                      .shrink(); // Rien afficher pour les autres
                }
              },
            );
          }

          return const Center(child: Text("No data available."));
        },
      ),
    );
  }
}
