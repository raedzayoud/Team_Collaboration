import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:dartz/dartz.dart';

abstract class TeamsRepo {
  
  Future<Either<Failure,void>> addNewTeam(String teamName, String teamDescription, String maxteamMembers);
  Future<Either<Failure,List<Team>>> getMyTeams();


}