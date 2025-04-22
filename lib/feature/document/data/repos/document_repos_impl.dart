import 'dart:convert';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/document/data/repos/document_repos.dart';
import 'package:http/http.dart' as http;

class DocumentReposImpl implements DocumentRepo {
  @override
  Future<String> summarizeText(String text) async {
    if (await checkInternet()) {
      final url = Uri.parse('http://127.0.0.1:5000/summarize');

      // final headers = {
      //   'Authorization': 'Token ad590be6d4cf7fdf8a284718a7071782108d0f5e',
      //   'Content-Type': 'application/json',
      // };

      final body = json.encode({
        'text': text,
      });

      final response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['summary']; // Extract the summary from the response
      } else {
        throw Exception("There was an error to summarize Text");
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }
}
