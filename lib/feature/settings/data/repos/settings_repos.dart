import 'package:collab_doc/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepos {
  Future<Either<Failure, void>> updateProfile({
    required String username,
  });
  Future<Either<Failure,void>>updateStatustoInActive();
}
