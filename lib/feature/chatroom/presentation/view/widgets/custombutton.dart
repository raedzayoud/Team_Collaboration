
import 'package:flutter/material.dart';

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
