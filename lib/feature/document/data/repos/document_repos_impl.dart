import 'dart:convert';
import 'package:collab_doc/core/utils/function/checkinternet.dart';
import 'package:collab_doc/feature/document/data/repos/document_repos.dart';
import 'package:http/http.dart' as http;

class DocumentReposImpl implements DocumentRepo {
  @override
  Future<String> summarizeText(String text) async {
    if (await checkInternet()) {
      final url = Uri.parse(
          'https://api.nlpcloud.io/v1/t5-base-en-generate-headline/summarization');

      final headers = {
        'Authorization': 'Token 71898a335a3c209aad689c4abb55b5dcde23f94a',
        'Content-Type': 'application/json',
      };

      final body = json.encode({
        'text': text,
        'length':
            'short', // You can also use 'long' or 'medium' depending on your preference
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['summary_text']; // Extract the summary from the response
      } else {
        throw Exception("There was an error to summarize Text");
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }
}
