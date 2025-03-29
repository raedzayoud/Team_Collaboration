import 'package:collab_doc/constant.dart';
import 'package:collab_doc/feature/gemini/presentation/view/widgets/chat_bubble.dart';
import 'package:collab_doc/feature/gemini/presentation/view/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
class GeminiChatBody extends StatefulWidget {
  const GeminiChatBody({super.key});

  @override
  State<GeminiChatBody> createState() => _GeminiChatBodyState();
}

class _GeminiChatBodyState extends State<GeminiChatBody> {
  late GenerativeModel model;
  late final ChatSession chat;
  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  final List<ChatMessage> messages = [];
  @override
  void initState() {
    model = GenerativeModel(apiKey: Api_Gemeni_Key, model: modelType);
    chat = model.startChat();
    super.initState();
  }

  void ScrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 650), curve: Curves.easeOutCirc));
  }

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add(ChatMessage(message, true));
    });
    try {
      final response = await chat.sendMessage(Content.text(message));
      final text = response.text;
      setState(() {
        messages.add(ChatMessage(text!, false));
        ScrollDown();
      });
    } catch (e) {
      setState(() {
        messages.add(ChatMessage("Error Occured", false));
      });
    } finally {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
              color: const Color.fromARGB(255, 224, 217, 217),
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(chatMessage: messages[index]);
                  }),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Enter a message',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              )),
              IconButton(
                  onPressed: () {
                    sendMessage(controller.text);
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
