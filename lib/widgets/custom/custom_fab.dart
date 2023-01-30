import 'package:flutter/material.dart';
import 'title_font.dart';

class CustomFAB extends StatelessWidget {
  CustomFAB({
    required this.text,
    required this.action,
    Key? key,
  }) : super(key: key);

  String text;
  VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: action,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: TitleFont(
          text: text,
          size: 32,
        ),
      ),
    );
  }
}
