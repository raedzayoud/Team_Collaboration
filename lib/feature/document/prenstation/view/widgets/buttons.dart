import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final void Function()? save;
  const Buttons({super.key, this.save});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.cancel),
            label: Text("Cancel"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
          ElevatedButton.icon(
            onPressed: save,
            icon: Icon(Icons.save),
            label: Text("Save"),
          ),
        ],
      ),
    );
  }
}
