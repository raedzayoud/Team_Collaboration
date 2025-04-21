import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/message_bubble.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/apparchat.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/buttonsmettings.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/messages.dart';
import 'package:collab_doc/feature/chatroom/presentation/view/widgets/textfieldmessage.dart';
import 'package:collab_doc/feature/teams/data/model/team.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  Team? team;
  String userId = "";
  List<Map<String, String>> messages = [];
  TextEditingController controller = TextEditingController();
  void sendMessage() async {
    if (!controller.text.isEmpty) {
      await FirebaseFirestore.instance.collection("message").add({
        "idteam": team!.id,
        "message": controller.text,
        "iduser": userId,
        "date": DateTime.now()
      });
      /* setState(() {});
      messages.insert(0, {"text": controller.text, "sender": "user"});
      await FirebaseFirestore.instance
          .collection("messages")
          .add({"text": controller.text, "sender": "user"});*/
    }
    controller.clear();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Team?;
      if (arguments != null) {
        setState(() {
          team = arguments;
        });
        print(
            "Chat opened for team----------------------------------: ${team!.name}");
      } else {
        print("No team provided!");
        Navigator.pop(context); // Go back safely if no team is passed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    if (team == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    userId = sharedPreferences.getString("id") ?? " ";
    return Scaffold(
      appBar: Apparchat(team!),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ButtonsMettings(),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("message")
                  .orderBy("date", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return const Center(child: Text("Empty ..."));
                }
                var listMessage = [];
                for (var item in snapshot.data!.docs) {
                  if (item.data()['idteam'] == team!.id) {
                    listMessage.add(item.data());
                  }
                }
                if (listMessage.isEmpty) {
                  return const Center(child: Text("No messages yet..."));
                }
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: listMessage.length,
                  itemBuilder: (context, index) {
                    return messageBubble(
                      message: listMessage[index]["message"] as String,
                      isMe: listMessage[index]['iduser'] == userId,
                    );
                  },
                );
              },
            ),
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
