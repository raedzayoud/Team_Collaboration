import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/chatroom/data/repos/chatroom_repo.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ChatroomRepoImpl implements ChatroomRepo {
  Dio dio = Dio();
  @override
  Future<Either<Failure, List<Team>>> getAllTeams() async {
    if (await checkInternet()) {
      try {
        // First request: get teams where user is a member
        var response1 = await dio.get(
          Applink.apiGetTheTeamAsMemeber,
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );

        // Second request: get user's own teams
        var response2 = await dio.get(
          Applink.apiGetMyteam,
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );

        // Convert both responses to List<Team>
        List<Team> teams1 = (response1.data as List)
            .map((teamData) => Team.fromJson(teamData))
            .toList();

        List<Team> teams2 = (response2.data as List)
            .map((teamData) => Team.fromJson(teamData))
            .toList();

        // Combine the two lists
        List<Team> finalTeams = [...teams1, ...teams2];

        return Right(finalTeams);
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
