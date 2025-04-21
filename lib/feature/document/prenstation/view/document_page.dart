import 'dart:async';
import 'package:collab_doc/feature/document/prenstation/view/modification_history_screen.dart';
import 'package:collab_doc/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';

class DocumentPage extends StatefulWidget {
  final String docId;
  const DocumentPage({super.key, required this.docId});
  @override
  // ignore: library_private_types_in_public_api
  _CRDTTextEditorState createState() => _CRDTTextEditorState();
}

class _CRDTTextEditorState extends State<DocumentPage> {
  var idd = const Uuid().v1();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String docId = "";
  final TextEditingController _controller = TextEditingController();
  final QuillController quillController = QuillController.basic();
  List<CRDTItem> items = [];
  int currentIndex = 0;
  StreamSubscription? _itemsSubscription;
  @override
  void initState() {
    super.initState();
    _listenForUpdates();
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
    print("rewrite here");
    print("controller index ${currentIndex}");
    _controller.selection = TextSelection.collapsed(offset: currentIndex);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("CRDT Text Editor"), actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ModificationHistoryScreen(documentId: widget.docId),
                ),
              );
            },
            child: Text("history"))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
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
