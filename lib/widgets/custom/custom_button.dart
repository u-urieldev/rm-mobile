import 'package:flutter/material.dart';
import '../../constans/custom_colors.dart';
import '../../providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    required this.action,
  }) : super(key: key);

  final Text label;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: CustomColors.kGreen,
          backgroundColor: CustomColors.kBlue,
          padding: const EdgeInsets.all(13),
          elevation: 7,
          side: const BorderSide(
            color: CustomColors.kGreen,
            width: 3,
            //style: BorderStyle.solid,
          ),
        ),
        onPressed: action,
        child: label,
      ),
    );
  }
}


// automaticallyImplyLeading
