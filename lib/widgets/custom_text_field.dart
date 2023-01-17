import 'package:flutter/material.dart';
import '../constans/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      required this.icon,
      required this.label,
      required this.controller})
      : super(key: key);

  final String label;
  final IconData icon;
  final Function(String) controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 53),
      child: TextFormField(
        cursorColor: CustomColors.kBlue,
        style: const TextStyle(color: CustomColors.kBlue),
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColors.kBlue)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColors.kGreen)),
          icon: Icon(
            icon,
            color: CustomColors.kGreen,
          ),
          labelStyle: const TextStyle(
            color: CustomColors.kBlue,
          ),
        ),
        onChanged: controller,
      ),
    );
  }
}
