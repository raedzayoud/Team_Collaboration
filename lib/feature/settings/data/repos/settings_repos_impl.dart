import 'dart:convert';

import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/settings/data/repos/settings_repos.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SettingsReposImpl implements SettingsRepos {
  Dio dio=Dio();
  @override
  Future<Either<Failure, void>> updateProfile({required String username})async {
    if (await checkInternet()) {
      //print(user.toJson());
      var response;
      try {
        response = await dio.put(
          Applink.apiModifyUser,
          data: {
            "username": username,
          },
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        return Right(null);
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
  
  @override
  Future<Either<Failure, void>> updateStatustoInActive()async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.patch(
          Applink.apiUpdateStatusUser,
          data: jsonEncode(false),
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        return Right(null);
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