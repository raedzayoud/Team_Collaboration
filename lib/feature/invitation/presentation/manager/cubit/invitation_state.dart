part of 'invitation_cubit.dart';

@immutable
abstract class InvitationState {}

class InvitationInitial extends InvitationState {}

class InvitationLoading extends InvitationState {}

class InvitationSuccess extends InvitationState {
  final List<InvitationModel>? invitations;

  InvitationSuccess({this.invitations});
}

class InvitationFailure extends InvitationState {
  final String? errorMessage;

  InvitationFailure({this.errorMessage});
}
