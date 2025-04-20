import 'dart:convert';
import 'dart:ffi';

import 'package:collab_doc/core/class/UserConnected.dart';
import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/core/utils/function/userPrefrences.dart';
import 'package:collab_doc/feature/authentication/data/model/user.dart';
import 'package:collab_doc/feature/authentication/data/repos/authentication_repo.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  Dio dio = Dio();
  @override
  Future<Either<Failure, void>> signIn(User user) async {
    if (await checkInternet()) {
      print(user.toJson());
      var response;
      try {
        response = await dio.post(
          Applink.apiSignup,
          data: user.toJson(),
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
  Future<Either<Failure, String>> login(
      String username, String password) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.post(
          Applink.apiLogin,
          data: {"username": username, "password": password},
        );
        String token = response.data['token'];
        if (token != null) {
          // Optionally: Save token in shared preferences or secure storage here
          response = await dio.get(
            Applink.apiUserDetails,
            options: Options(
              headers: {
                "Authorization": "Bearer ${token}",
              },
            ),
          );
          Userprefrences.saveUserToPrefs(UserConnected(
              email: response.data['email'],
              id: response.data['id'],
              isActive: response.data['isActive'] ?? false,
              username: response.data['username']));

          return Right(token);
        } else {
          return Left(ServeurFailure(errorsMessage: "Invalid token received"));
        }
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
  Future<Either<Failure, void>> updateStatustoActive() async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.patch(
          Applink.apiUpdateStatusUser,
          data: jsonEncode(true),
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
