import 'package:collab_doc/constant.dart';
import 'package:collab_doc/utils/assets.dart';
import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return text != "Continue with Google"
        ? button(text: text, onPressed: onPressed)
        : Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: KPrimayColor, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: Image.asset(AssetsImage.google)),
              MaterialButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
          
  }
}


class button extends StatelessWidget {
  const button({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: KPrimayColor, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: MaterialButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
        ),
      ),
    );
  }
}