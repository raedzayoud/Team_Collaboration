import 'package:collab_doc/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class InvitationRepo {
  Future<Either<Failure,void>> sendInvitation(String emailReciver,int teamid);
}