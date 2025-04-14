import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/feature/authentication/presentation/data/model/user.dart';
import 'package:collab_doc/feature/authentication/presentation/data/repos/authentication_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  Dio dio = Dio();
  @override
  Future<Either<Failure, void>> signIn(User user) async {
    var response;
    try {
      response = await dio.post(
        'http://localhost:8080/api/v1/users',
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(ServeurFailure(errorsMessage: response.data['message']));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServeurFailure.fromDioError(e));
      }
      return Left(ServeurFailure(errorsMessage: response.data['message']));
    }
  }
}
