import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:collab_doc/feature/home/data/repos/home_repos.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeReposImpl implements HomeRepos {
  Dio dio = Dio();

  @override
  Future<Either<Failure, UserDetails>> getUserDetails() async {
    if (await checkInternet()) {
      try {
        final token = infoUserSharedPreferences.getString("token");

        var response = await dio.get(
          Applink.apiUserDetails,
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );

        final userDetails = UserDetails.fromJson(response.data);
        return Right(userDetails);
      } catch (e) {
        if (e is DioException) {
          return Left(ServeurFailure.fromDioError(e));
        }
        return Left(ServeurFailure(errorsMessage: e.toString()));
      }
    } else {
      return Left(ServeurFailure(errorsMessage: "No Internet Connection"));
    }
  }
}
