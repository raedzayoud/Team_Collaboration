import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final String sampleText =
        "Flutter is an open-source UI software development kit created by Google. It is used to develop applications for mobile, web, and desktop from a single codebase.";

    Future<String> summarizeText(String text) async {
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
        throw Exception('Failed to summarize text');
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Text Summarizer')),
      body: Center(
        child: FutureBuilder<String>(
          future: summarizeText(sampleText),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Summary: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
