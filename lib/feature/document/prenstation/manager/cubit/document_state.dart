part of 'document_cubit.dart';

@immutable
sealed class DocumentState {}

final class DocumentInitial extends DocumentState {}
final class DocumentLoading extends DocumentState {}
final class DocumentSuccess extends DocumentState {}
final class DocumentFailure extends DocumentState {}
