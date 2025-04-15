part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;
  AuthenticationFailure({required this.errorMessage});
}

final class AuthenticationSuccess extends AuthenticationState {}

final class LoginSuccess extends AuthenticationState {
  final String token;
  LoginSuccess({required this.token});
}

final class LoginFailure extends AuthenticationState {
  final String errorMessage;
  LoginFailure({required this.errorMessage});
}

final class LoginLoading extends AuthenticationState {}
