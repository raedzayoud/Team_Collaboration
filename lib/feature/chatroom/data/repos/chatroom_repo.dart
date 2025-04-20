import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:dartz/dartz.dart';

abstract class ChatroomRepo {
   Future<Either<Failure, List<Team>>> getAllTeams();
}
