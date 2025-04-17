part of 'team_cubit.dart';

@immutable
sealed class TeamState {}

final class TeamInitial extends TeamState {}

final class TeamSuccess extends TeamState {}

final class TeamFailure extends TeamState {
  final String errorsMessage;
  TeamFailure({required this.errorsMessage});
}

final class TeamLoading extends TeamState {}

final class MyTeamLoading extends TeamState {}

final class MyTeamSuccess extends TeamState {
  final List<Team>myteams;
  MyTeamSuccess({required this.myteams});
}

final class MyTeamFailure extends TeamState {
  final String errorsMessage;
  MyTeamFailure({required this.errorsMessage});
}
