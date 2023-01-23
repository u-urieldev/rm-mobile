import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import '../../constans/custom_colors.dart';

class WaitingIndicator extends StatelessWidget {
  const WaitingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: LiquidCircularProgressIndicator(
          value: 0.6,
          valueColor: const AlwaysStoppedAnimation(CustomColors.kGreen),
          backgroundColor: Colors.black,
          borderColor: Colors.black,
          borderWidth: 5.0,
          direction: Axis.vertical,
          center: const Text(
            "Loading...",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
