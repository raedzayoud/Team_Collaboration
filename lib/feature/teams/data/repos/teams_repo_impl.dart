import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/feature/teams/data/repos/teams_repo.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TeamsRepoImpl implements TeamsRepo {
  Dio dio = Dio();
  @override
  Future<Either<Failure, void>> addNewTeam(
      String teamName, String teamDescription, String maxteamMembers) async {
    if (await checkInternet()) {
      var response;
      try {
        response = await dio.post(
          Applink.apiAddTeam,
          data: {
            "teamName": teamName,
            "teamDescription": teamDescription,
            "maxMembers": maxteamMembers
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
  Future<Either<Failure, List<Team>>> getMyTeams() async {
    if (await checkInternet()) {
      var response;
      try {
        response = await dio.get(
          Applink.apiGetMyteam,
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        List<Team> teams = (response.data as List)
            .map((teamData) => Team.fromJson(teamData))
            .toList();
        return Right(teams);
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
  Future<Either<Failure, List<Team>>> getMyTeamsAsMemeber()async {
    if (await checkInternet()) {
      var response;
      try {
        response = await dio.get(
          Applink.apiGetTheTeamAsMemeber,
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        List<Team> teams = (response.data as List)
            .map((teamData) => Team.fromJson(teamData))
            .toList();
        return Right(teams);
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
