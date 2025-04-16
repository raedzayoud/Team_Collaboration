part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsFailure extends SettingsState {
  final String message;
  SettingsFailure({required this.message});
}

final class SettingsSuccess extends SettingsState {}

final class SettingsLoading extends SettingsState {}
