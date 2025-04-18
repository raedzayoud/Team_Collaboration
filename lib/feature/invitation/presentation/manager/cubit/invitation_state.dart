part of 'invitation_cubit.dart';

@immutable
sealed class InvitationState {}

final class InvitationInitial extends InvitationState {}
final class InvitationLoading extends InvitationState {}
final class InvitationSuccess extends InvitationState {}
final class InvitationFailure extends InvitationState {
  final String? errorMessage;

  InvitationFailure({required this.errorMessage});
}
