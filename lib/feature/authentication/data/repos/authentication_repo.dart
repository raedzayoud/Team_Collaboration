import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/feature/authentication/data/model/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, void>> signIn(User user);
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, void>> updateStatustoActive();
}
