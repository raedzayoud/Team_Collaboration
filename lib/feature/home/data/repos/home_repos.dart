import 'package:collab_doc/core/error/failure.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepos {
  Future<Either<Failure, UserDetails>> getUserDetails();
}