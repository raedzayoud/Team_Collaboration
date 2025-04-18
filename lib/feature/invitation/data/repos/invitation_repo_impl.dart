import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/invitation/data/repos/invitation_repo.dart';
import 'package:collab_doc/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class InvitationRepoImpl implements InvitationRepo {
  Dio dio=Dio();
  @override
  Future<Either<Failure, void>> sendInvitation(String emailReciver, int teamid)async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.patch(
          Applink.apiSendInvitation,
          data: {
            "emailReceiver": emailReciver,
            "teamId": teamid,
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
}