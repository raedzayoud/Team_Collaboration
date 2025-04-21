import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ModificationHistoryScreen extends StatefulWidget {
  final String documentId;
  const ModificationHistoryScreen({required this.documentId, Key? key})
      : super(key: key);

  @override
  State<ModificationHistoryScreen> createState() =>
      _ModificationHistoryScreenState();
}

class _ModificationHistoryScreenState extends State<ModificationHistoryScreen> {
  String? selectedUser;

  @override
  Widget build(BuildContext context) {
    final itemsRef = FirebaseFirestore.instance
        .collection('documents')
        .doc(widget.documentId)
        .collection('items');

    return Scaffold(
      appBar: AppBar(title: const Text('Modification History')),
      body: Column(
        children: [
          // 🔍 Users Filter
          StreamBuilder<QuerySnapshot>(
            stream: itemsRef.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();
              final allDocs = snapshot.data!.docs;

              final users =
                  allDocs.map((doc) => doc.id.split('@').last).toSet().toList();

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text("All"),
                      selected: selectedUser == null,
                      onSelected: (_) => setState(() => selectedUser = null),
                    ),
                    const SizedBox(width: 8),
                    ...users.map((user) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(user),
                            selected: selectedUser == user,
                            onSelected: (_) =>
                                setState(() => selectedUser = user),
                          ),
                        )),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          // 📃 List of Modifications
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  itemsRef.orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());

                final allItems = snapshot.data!.docs.where((doc) {
                  final userFromId = doc.id.split('@').last;
                  return selectedUser == null || userFromId == selectedUser;
                }).toList();

                if (allItems.isEmpty) {
                  return const Center(child: Text('No modifications found.'));
                }

                return ListView.builder(
                  itemCount: allItems.length,
                  itemBuilder: (context, index) {
                    final doc = allItems[index];
                    final docId = doc.id;
                    final username = docId.split('@').last;
                    final content = doc['content'];
                    final timestampMillis = doc['timestamp'] as int;
                    final action = doc['action'];
                    final date =
                        DateTime.fromMillisecondsSinceEpoch(timestampMillis);
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm').format(date);

                    return ListTile(
                      title: Text(content),
                      subtitle: Text('By $username • $formattedDate'),
                      trailing: Text(action),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
