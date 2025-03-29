import 'package:collab_doc/feature/home/presentation/view/widget/apparhome.dart';
import 'package:collab_doc/feature/home/presentation/view/widget/texthome.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            ApparHome(),
            const SizedBox(
              height: 20,
            ),
            Texthome(text: "Recent Document"),
          ],
        ),
      ),
    );
  }
}
