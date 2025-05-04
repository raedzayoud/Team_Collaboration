import 'dart:async';
import 'package:collab_doc/constant.dart';
import 'package:collab_doc/core/class/applink.dart';
import 'package:collab_doc/core/utils/function/snackbar.dart';
import 'package:collab_doc/feature/document/prenstation/manager/cubit/document_cubit.dart';
import 'package:collab_doc/feature/document/prenstation/view/modification_history_screen.dart';
import 'package:collab_doc/feature/document/prenstation/view/widgets/showdialog_scissors.dart';
import 'package:collab_doc/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DocumentPage extends StatefulWidget {
  final String docId;
  const DocumentPage({super.key, required this.docId});
  @override
  // ignore: library_private_types_in_public_api
  _CRDTTextEditorState createState() => _CRDTTextEditorState();
}

class _CRDTTextEditorState extends State<DocumentPage> {
  var idd = const Uuid().v1();
  stt.SpeechToText speechToText = stt.SpeechToText();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String docId = "";
  final TextEditingController _controller = TextEditingController();
  final QuillController quillController = QuillController.basic();
  bool enable = true;
  List<CRDTItem> items = [];
  int currentIndex = 0;
  StreamSubscription? _itemsSubscription;
  @override
  void initState() {
    super.initState();
    _listenForUpdates();
    init();
    checkUser();
  }

  bool _speechEnalbled = false;
  String _wordSpoken = "";

  void startListening() async {
    if (!_speechEnalbled) {
      return;
    }
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void onSpeechResult(result) {
    setState(() {
      _wordSpoken = "${result.recognizedWords}";
    });

    if (_wordSpoken.isNotEmpty) {
      final selection = _controller.selection;

      // If there's no valid cursor position, append to the end
      int baseOffset =
          selection.isValid ? _controller.text.length : selection.baseOffset;

      // Insert the spoken text at the current cursor position
      final newText = _controller.text.substring(0, baseOffset) +
          "$_wordSpoken " +
          _controller.text.substring(baseOffset);

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: baseOffset +
              _wordSpoken.length +
              1, // Move cursor after inserted text
        ),
      );
    }
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void init() async {
    _speechEnalbled = await speechToText.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _itemsSubscription?.cancel(); // 🧹 Cancel the subscription
    _controller.dispose(); // 🧹 Dispose of the text  controller
    deleteController();
    super.dispose();
  }

  void deleteController() async {
    await _db
        .collection("documents")
        .doc(docId)
        .collection("cursors")
        .doc(idd)
        .delete();
  }

  void checkUser() async {
    var idUser = sharedPreferences.getString("id");
    final dio = Dio();
    var idDocument = widget.docId;
    DocumentSnapshot<Map<String, dynamic>> document = await FirebaseFirestore
        .instance
        .collection("documents")
        .doc(idDocument)
        .get();
    var idTeam = document.data()!["teamId"];

    print(idTeam);

    final response2 = await dio.get(
      Applink.apiTeamDetailsById +
          "${idTeam}", // make sure you define this in your Applink class

      options: Options(
        headers: {
          "Authorization":
              "Bearer ${infoUserSharedPreferences.getString("token")}",
        },
      ),
    );
    print(response2);

    if (response2.data is Map<String, dynamic>) {
      var data = response2.data as Map<String, dynamic>;

      if (data['userOwner']['id'] == idUser) {
        enable = true;

        setState(() {});
        return;
      } else {
        enable = false;
      }
    }

    final response = await dio.get(
      Applink
          .apiGetUserRoleTeam, // make sure you define this in your Applink class
      data: {"userId": idUser, "teamId": idTeam},
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${infoUserSharedPreferences.getString("token")}",
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data == "EDITEUR") {
        enable = true;
      } else {
        enable = false;
      }

      // Extract the summary from the response
    }
    setState(() {});
  }

  void _listenForUpdates() {
    _itemsSubscription = _db
        .collection("documents")
        .doc(widget.docId)
        .collection("cursors")
        .doc(idd)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return; // ✅ Check if mounted before calling  setState
      if (snapshot.exists) {
        setState(() {
          var doc = snapshot.data();
          if (doc!['position'] != null) {
            //  _controller.selection =    TextSelection.collapsed(offset: doc['position'] ?? 0);
          }
        });
      }
    });
    _itemsSubscription = _db
        .collection("documents")
        .doc(widget.docId)
        .collection("items")
        .where("isDeleted", isEqualTo: false)
        .orderBy("index", descending: false)
        .snapshots()
        .listen((snapshot) {
      if (!mounted) return;

      items =
          snapshot.docs.map((doc) => CRDTItem.fromJson(doc.data())).toList();
      if (_controller.text != _getText()) {
        _controller.text = _getText();
        _controller.selection = _controller.selection =
            TextSelection.collapsed(offset: currentIndex);
      }
      setState(() {});
    });
  }

  String _getText() {
    return items
        .where((item) => !item.isDeleted)
        .map((e) => e.content)
        .join("");
  }

  void _insertCharacter(String content) {
    final String username = sharedPreferences.getString("username") ?? " ";
    String id = "${DateTime.now().millisecondsSinceEpoch}@${username}";
    double index = -1;
    bool test = false;
    String motAdded = "";
    if (items.isEmpty) {
      motAdded = content;
      index = 0;
    }
    int i = 0;
    int j = 0;
    while (i < items.length && index == -1 && j < content.length) {
      while (i < items.length && items[i].isDeleted == true) {
        i++;
      }

      if (index == -1 &&
          i < items.length &&
          items[i].content != content[j] &&
          items[i].isDeleted == false) {
        test = true;
        motAdded = content[j];
        index = (items[i].index + (items[i].index - 1)) / 2;
        break;
      }
      j++;
      i++;
    }
    if (index == -1 && test == false) {
      motAdded = content[content.length - 1];
      index = items.last.index + 1;
    }
    CRDTItem newItem = CRDTItem(
        action: "add",
        index: index,
        id: id,
        content: motAdded,
        isDeleted: false,
        timestamp: DateTime.now().millisecondsSinceEpoch);
    _db
        .collection("documents")
        .doc(widget.docId)
        .collection("items")
        .doc(id)
        .set(newItem.toJson());
    /*   _db
        .collection("docs")
        .doc(docId)
        .collection("cursors")
        .doc(idd)
        .set({"index": _controller.selection.baseOffset});*/
  }

  void _deleteCharacter() async {
    final String username = sharedPreferences.getString("username") ?? " ";
    if (_controller.text.isEmpty) {
      for (var item in items) {
        if (item.isDeleted == false) {
          _db
              .collection("documents")
              .doc(widget.docId)
              .collection("items")
              .doc(item.id)
              .update({
            "isDeleted": true,
          });
        }
      }
      _db.collection("documents").doc(widget.docId);
    }
    if (items.isNotEmpty) {
      int i = 0;
      String id = "";
      while (i < _controller.text.length && i < items.length) {
        if (i < items.length) {
          if (items[i].isDeleted == false &&
              items[i].content != _controller.text[i]) {
            items[i].isDeleted = true;
            id = items[i].id;
            await _db
                .collection("documents")
                .doc(widget.docId)
                .collection("items")
                .doc(id)
                .update({"isDeleted": true});
            return;
          }
        }
        i++;
      }
      while (i < items.length) {
        id = items[i].id;
        if (items[i].isDeleted == false) {
          await _db
              .collection("documents")
              .doc(widget.docId)
              .collection("items")
              .doc(id)
              .update({"isDeleted": true});
        }

        i++;
      }
      // _db
      //     .collection("docs")
      //     .doc(docId)
      //     .collection("items")
      //     .doc(id)
      //     .update({"isDeleted": true});
      // _db
      //     .collection("docs")
      //     .doc(docId)
      //     .collection("cursors")
      //     .doc(idd)
      //     .set({"index": _controller.selection.baseOffset});
    }
  }

  @override
  Widget build(BuildContext context) {
    docId = widget.docId;

    _controller.selection = TextSelection.collapsed(offset: currentIndex);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: KPrimayColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "CRDT Text Editor",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // keep it centered
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ModificationHistoryScreen(documentId: docId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                backgroundColor: Colors.white.withOpacity(0.15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0, // No shadow inside AppBar
              ),
              icon: const Icon(Icons.history, size: 18, color: Colors.white),
              label: const Text(
                "History",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocListener<DocumentCubit, DocumentState>(
              listener: (context, state) {
                if (state is DocumentFailure) {
                  snackbarerror(context, state.errorMessage);
                } else if (state is DocumentSuccess) {
                  _controller.text = state.summary;
                }
              },
              child: BlocBuilder<DocumentCubit, DocumentState>(
                builder: (context, state) {
                  if (state is DocumentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  print("this in bloc builder ${enable}");
                  return TextField(
                    readOnly: !enable,
                    maxLines: 20,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.black))),
                    controller: _controller,
                    onChanged: (text) {
                      // calculateCharacterPositions();
                      if (text.length > _getText().length) {
                        currentIndex = _controller.selection.baseOffset;
                        _insertCharacter(text);
                      } else if (text.length < _getText().length) {
                        currentIndex = _controller.selection.baseOffset;
                        _deleteCharacter();
                      }
                    },
                  );
                },
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    if (speechToText.isListening) {
                      stopListening();
                    } else {
                      startListening();
                    }
                  },
                  icon: Icon(
                    speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.content_cut_outlined),
                  onPressed: () {
                    showDialogScissors(
                      context: context,
                      textEditingController: _controller,
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter text to summarize."),
                            ),
                          );
                          Navigator.of(context).pop();
                          return;
                        }
                        BlocProvider.of<DocumentCubit>(context).summarizeText(
                          _controller.text,
                        );
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🏗 CRDT Item Model
class CRDTItem {
  final String id;
  final String content;
  final int timestamp;
  bool isDeleted;
  final double index;
  final String action;
  CRDTItem(
      {required this.id,
      required this.action,
      required this.index,
      required this.content,
      required this.timestamp,
      this.isDeleted = false});
  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'timestamp': timestamp,
        'isDeleted': isDeleted,
        'index': index,
        'action': action
      };
  static CRDTItem fromJson(Map<String, dynamic> json) {
    return CRDTItem(
      action: json['action'],
      id: json['id'],
      index: json['index'].toDouble(),
      content: json['content'],
      timestamp: json['timestamp'],
      isDeleted: json['isDeleted'] ?? false,
    );
  }
}
