import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/feature/invitation/data/mdoel/invitation.dart';
import 'package:dartz/dartz.dart';

abstract class InvitationRepo {
  Future<Either<Failure,void>> sendInvitation(String emailReciver,int teamid);
  Future<Either<Failure,void>> acceptInvitation(int Invitationid);
  Future<Either<Failure,void>> rejectInvitation(int Invitationid);
  Future<Either<Failure,List<InvitationModel>>> myInvitationIrecived();

}