import 'package:collab_doc/feature/gemini/presentation/view/widgets/gemini_chat_body.dart';
import 'package:flutter/material.dart';

class GeminiChat extends StatelessWidget {
  const GeminiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ai ChatBot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GeminiChatBody(),
    );
  }
}
