import 'dart:ui';

import 'package:collab_doc/core/utils/responsive.dart';
import 'package:collab_doc/feature/authentication/presentation/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Newteam extends StatefulWidget {
  const Newteam({super.key});

  @override
  State<Newteam> createState() => _NewteamState();
}

class _NewteamState extends State<Newteam> {
  TextEditingController teamNameController = TextEditingController();
  @override
  void dispose() {
    teamNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin:
                  EdgeInsets.only(right: AppResponsive.width(context) * .06),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.group,
                  color: Color.fromARGB(255, 231, 153, 35)),
            ),
            const Text(
              "Create New Team",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Team Name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            CustomTextField(
              controller: teamNameController,
              hintText: "Team Name",
              obscureText: false,
              suffixIcon: Icon(Icons.group_sharp),
              validator: (val) {},
            ),
            const SizedBox(height: 10),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: teamNameController,
              hintText: "Description",
              obscureText: false,
              suffixIcon: Icon(Icons.group_sharp),
              validator: (val) {},
            ),
            const SizedBox(height: 16),
            
          ],
        ),
      ),
    );
  }
}
