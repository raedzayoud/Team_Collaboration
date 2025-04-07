
import 'package:collab_doc/constant.dart';
import 'package:flutter/material.dart';

class ButtonsEditProfile extends StatelessWidget {
  const ButtonsEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context); // Cancel goes back
          },
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.cancel, color: Colors.white),
              SizedBox(width: 8),
              Text("Cancel", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            // Handle save action
          },
          color: KPrimayColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: const [
              Icon(Icons.save, color: Colors.white),
              SizedBox(width: 8),
              Text("Save", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
