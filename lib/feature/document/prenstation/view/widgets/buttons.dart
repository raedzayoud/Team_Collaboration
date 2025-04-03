import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
class Buttons extends StatelessWidget {
  final SpeechToText speechToText;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function()? save;

  const Buttons({
    super.key,
    this.save,
    required this.speechToText,
    required this.startListening,
    required this.stopListening,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.cancel, color: Colors.white),
            label: Text("Cancel", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
          ),
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
          ElevatedButton.icon(
            onPressed: save,
            icon: Icon(Icons.save, color: Colors.white),
            label: Text("Save", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
            ),
          ),
        ],
      ),
    );
  }
}
