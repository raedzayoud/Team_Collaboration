import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/apparchat.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/buttonsmettings.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/messages.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/textfieldmessage.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  int? id;
  List<Map<String, String>> messages = [];
  TextEditingController controller = TextEditingController();
  void sendMessage() async {
    if (!controller.text.isEmpty) {
      setState(() {});
      messages.insert(0, {"text": controller.text, "sender": "user"});
      await FirebaseFirestore.instance
          .collection("messages")
          .add({"text": controller.text, "sender": "user"});
    }
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments as int?;
      setState(() {
        id = arguments ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Apparchat(),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ButtonsMettings(),
          Messages(
            messages: messages,
          ),
          TextFieldMessage(
            controller: controller,
            onPressed: sendMessage,
          )
        ],
      ),
    );
  }
}
