import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo.dart';
import 'package:meta/meta.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  InvitationRepo invitationRepo;
  InvitationCubit(this.invitationRepo) : super(InvitationInitial());

  void sendInvitation(String emailReciver, int teamid) async {
    emit(InvitationLoading());
    try {
      // Simulate a network call
      // Call the repository method to send the invitation
      final result = await invitationRepo.sendInvitation(emailReciver, teamid);
      result.fold(
        (failure) {
          emit(InvitationFailure(errorMessage: failure.errorMessage));
        },
        (success) {
          emit(InvitationSuccess());
        },
      );
      // }
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }

  void myInvitationIrecived() async {
    emit(InvitationLoading());
    try {
      // Simulate a network call
      // Call the repository method to send the invitation
      final result = await invitationRepo.myInvitationIrecived();
      result.fold(
        (failure) {
          emit(InvitationFailure(errorMessage: failure.errorMessage));
        },
        (success) {
          emit(InvitationSuccess(invitations: success));
        },
      );
      // }
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }
}
