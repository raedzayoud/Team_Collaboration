import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InvitationRepoImpl implements InvitationRepo {
  Dio dio = Dio();
  @override
  Future<Either<Failure, void>> sendInvitation(
      String emailReciver, int teamid, String role) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.post(
          Applink.apiInvitation,
          data: {"emailReceiver": emailReciver, "teamId": teamid, "role": role},
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
  Future<Either<Failure, void>> acceptInvitation(int Invitationid) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.patch(
          Applink.apiInvitation,
          data: {"invitationId": Invitationid, "status": "ACCEPTED"},
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
  Future<Either<Failure, void>> rejectInvitation(int Invitationid) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.patch(
          Applink.apiInvitation,
          data: {"invitationId": Invitationid, "status": "REJECTED"},
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
  Future<Either<Failure, List<InvitationModel>>> myInvitationIrecived() async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.get(
          Applink.apiMyInvitationIrecived,
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        List<InvitationModel> invitations = (response.data as List)
            .map((e) => InvitationModel.fromJson(e))
            .toList();
        return Right(invitations);
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
  Future<Either<Failure, Team>> getTeamDetailsById(int idTeam) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.get(
          Applink.apiTeamDetailsById + idTeam.toString(),
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        Team teamDetails = Team.fromJson(response.data);
        return Right(teamDetails);
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
  Future<Either<Failure, UserDetails>> getUserDetailsById(int idUser) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.get(
          Applink.apiUserDetailsById + idUser.toString(),
          options: Options(
            headers: {
              "Authorization":
                  "Bearer ${infoUserSharedPreferences.getString("token")}",
            },
          ),
        );
        UserDetails userDetails = UserDetails.fromJson(response.data);
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
