part of 'chatroom_cubit.dart';

@immutable
sealed class ChatroomState {}

final class ChatroomInitial extends ChatroomState {}

final class ChatroomLoading extends ChatroomState {}

final class ChatroomSuccess extends ChatroomState {
  final List<Team> teams;
  ChatroomSuccess(this.teams);
}

final class ChatroomFailure extends ChatroomState {
  final String errorMessage;
  ChatroomFailure(this.errorMessage);
}
