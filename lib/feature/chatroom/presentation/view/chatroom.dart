import 'package:collab_doc/constant.dart';
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
  void sendMessage() {
    if (!controller.text.isEmpty) {
      setState(() {});
      messages.insert(0, {"text": controller.text, "sender": "user"});
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(name: "New Mettings",onPressed: (){},),
              SizedBox(
                width: 10,
              ),
              CustomButton(name: "Join Mettings",onPressed: (){},),
              SizedBox(
                width: 10,
              )
            ],
          ),
          Expanded(
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
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.black : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          messages[index]["text"]!,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ));
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
                      hintText: "Type your message here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: KPrimayColor, width: 2),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      color: KPrimayColor,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Apparchat extends StatelessWidget implements PreferredSizeWidget {
  const Apparchat();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: KPrimayColor,
      centerTitle: true,
      title: Text(
        "Chat Room",
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  const CustomButton({super.key, required this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
        side: BorderSide(color: Colors.black, width: 1), // Border
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding
      child: Row(
        mainAxisSize: MainAxisSize.min, // Prevent excessive width
        children: [
          Icon(Icons.video_call, color: Colors.black), // Added icon
          SizedBox(width: 8), // Space between icon and text
          Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
