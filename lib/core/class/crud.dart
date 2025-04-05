import 'dart:convert';
import 'package:collab_doc/core/class/statusrequest.dart';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class Crud {
  // POST method
  Future<Either<StatusRequest, Map>> postData(
      String linkapi, Map<String, String> data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(linkapi), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverexception);
    }
  }

  // GET method
  Future<Either<StatusRequest, Map>> getData(String linkapi) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(linkapi));
        if (response.statusCode == 200) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverexception);
    }
  }

  // PUT method
  Future<Either<StatusRequest, Map>> putData(
      String linkapi, Map<String, String> data) async {
    try {
      if (await checkInternet()) {
        var response = await http.put(Uri.parse(linkapi), body: data);
        if (response.statusCode == 200 || response.statusCode == 204) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverexception);
    }
  }

  // DELETE method
  Future<Either<StatusRequest, Map>> deleteData(String linkapi) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(Uri.parse(linkapi));
        if (response.statusCode == 200 || response.statusCode == 204) {
          Map responseBody = response.body.isNotEmpty
              ? jsonDecode(response.body)
              : {'message': 'Deleted successfully'};
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (e) {
      return const Left(StatusRequest.serverexception);
    }
  }
}
