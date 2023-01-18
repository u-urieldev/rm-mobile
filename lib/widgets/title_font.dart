import 'package:flutter/material.dart';
import '../constans/custom_colors.dart';

class TitleFont extends StatelessWidget {
  TitleFont({Key? key, required this.text, required this.size})
      : super(key: key);

  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Implement the stroke
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            letterSpacing: 3,
            fontWeight: FontWeight.normal,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.7
              ..color = CustomColors.kGreen,
          ),
        ),
        // The text inside
        Text(
          text,
          style: TextStyle(
            fontSize: size,
            letterSpacing: 3,
            fontWeight: FontWeight.normal,
            color: CustomColors.kBlue,
          ),
        ),
      ],
    );
  }
}
