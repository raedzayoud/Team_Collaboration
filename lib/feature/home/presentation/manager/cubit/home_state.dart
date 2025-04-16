part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeFailure extends HomeState {}

final class HomeSuccess extends HomeState {}

final class HomeLoading extends HomeState {}

final class UserFailure extends HomeState {
  final String errorMessage;
  UserFailure({required this.errorMessage});
}

final class UserSuccess extends HomeState {
  UserDetails userDetails;
  UserSuccess({required this.userDetails});
}

final class UserLoading extends HomeState {}
