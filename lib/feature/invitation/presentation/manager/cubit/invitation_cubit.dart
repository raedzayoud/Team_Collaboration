import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
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
        (failure) =>
            emit(InvitationFailure(errorMessage: failure.errorMessage)),
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
        (failure) =>
            emit(InvitationFailure(errorMessage: failure.errorMessage)),
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
        (failure) =>
            emit(InvitationFailure(errorMessage: failure.errorMessage)),
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
        (failure) =>
            emit(InvitationFailure(errorMessage: failure.errorMessage)),
        (_) => myInvitationIrecived(), // Refresh list after action
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
    }
  }

  Future<Team> getTeamDetailsById(int idTeam) async {
    try {
      final result = await invitationRepo.getTeamDetailsById(idTeam);
      return result.fold(
        (failure) => throw Exception(failure.errorMessage),
        (success) => success,
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
      //throw Exception('Failed to fetch team details: ${e.toString()}');
      return Team(
        id: 0,
        name: '',
        description: '',
        maxMembers: 0,
        userOwner: null, // Provide default UserDetails
        members: [], // Provide an empty list for members
      ); // Return an empty Team object or handle it as needed
    }
  }

  Future<UserDetails> getUserDetailsById(int idUser) async {
    try {
      final result = await invitationRepo.getUserDetailsById(idUser);
      return result.fold(
        (failure) => throw Exception(failure.errorMessage),
        (success) => success,
      );
    } catch (e) {
      emit(InvitationFailure(errorMessage: e.toString()));
      // throw Exception('Failed to fetch UserDetails details: ${e.toString()}');
      return UserDetails(
          id: 0,
          email: '',
          active: false,
          username:
              ""); // Return an empty UserDetails object or handle it as needed
    }
  }
}
