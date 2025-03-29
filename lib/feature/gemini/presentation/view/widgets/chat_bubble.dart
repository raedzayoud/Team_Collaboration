import 'package:collab_doc/feature/gemini/presentation/view/widgets/chat_message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage chatMessage;
  const ChatBubble({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatMessage.idUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width /
                1.25 // Ensure the parent widget allows the child to have this width
            ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: chatMessage.idUser ? Colors.blue[300] : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomRight: chatMessage.idUser
                  ? const Radius.circular(2)
                  : const Radius.circular(16),
              bottomLeft: chatMessage.idUser
                  ? const Radius.circular(16)
                  : const Radius.circular(2),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: Offset(2, 2))
            ]),
        child: Text(
          chatMessage.text,
          style: TextStyle(fontSize: 16,color: chatMessage.idUser?Colors.white:Colors.black87),
        ),
      ),
    );
  }
}
