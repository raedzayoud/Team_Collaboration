part of 'mettings_cubit.dart';

@immutable
sealed class MettingsState {}

final class MettingsInitial extends MettingsState {}
final class MettingsLoading extends MettingsState {}
final class MettingsSuccess extends MettingsState {}
final class MettingsFailure extends MettingsState {}
