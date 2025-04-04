
import 'package:collab_doc/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final List<Map<String, String>> messages;
  const Messages({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            bool isUser = messages[index]["sender"] == "user";
            return Align(
                alignment:
                    isUser ? Alignment.bottomRight : Alignment.centerLeft,
                child: Container(
                  width: AppResponsive.width(context) * .4,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.black : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    messages[index]["text"]!,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ));
          }),
    ));
  }
}
