import 'dart:convert';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/document/data/repos/document_repos.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DocumentReposImpl implements DocumentRepo {
  Dio dio = Dio();
  @override
  Future<String> summarizeText(String text) async {
    if (await checkInternet()) {
      final response = await dio.post(
        "http://192.168.70.159:5000/summarize", // make sure you define this in your Applink class
        data: {"text": text},
        
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return data['summary']; // Extract the summary from the response
      } else {
        throw Exception("There was an error to summarize Text");
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }
}
