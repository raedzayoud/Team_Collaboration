import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo.dart';
import 'package:meta/meta.dart';

part 'invitation_state.dart';

class InvitationCubit extends Cubit<InvitationState> {
  final InvitationRepo invitationRepo;
  
  InvitationCubit(this.invitationRepo) : super(InvitationInitial());

  void sendInvitation(String emailReciver, int teamid) async {
    emit(InvitationLoading());
    try {
      final result = await invitationRepo.sendInvitation(emailReciver, teamid);
      result.fold(
        (failure) => emit(InvitationFailure(errorMessage: failure.errorMessage)),
        (_) => emit(InvitationSuccess(invitations: null)),
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }

  void myInvitationIrecived() async {
    emit(InvitationLoading());
    try {
      final result = await invitationRepo.myInvitationIrecived();
      result.fold(
        (failure) => emit(InvitationFailure(errorMessage: failure.errorMessage)),
        (success) => emit(InvitationSuccess(invitations: success)),
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }

  void acceptInvitation(int invitationId) async {
    emit(InvitationLoading());
    try {
      final result = await invitationRepo.acceptInvitation(invitationId);
      result.fold(
        (failure) => emit(InvitationFailure(errorMessage: failure.errorMessage)),
        (_) => myInvitationIrecived(), // Refresh list after action
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }

  void rejectInvitation(int invitationId) async {
    emit(InvitationLoading());
    try {
      final result = await invitationRepo.rejectInvitation(invitationId);
      result.fold(
        (failure) => emit(InvitationFailure(errorMessage: failure.errorMessage)),
        (_) => myInvitationIrecived(), // Refresh list after action
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }
}
