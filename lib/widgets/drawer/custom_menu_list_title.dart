import 'package:flutter/material.dart';
import '../../constans/custom_colors.dart';

class CustomMenuListTitle extends StatelessWidget {
  const CustomMenuListTitle({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: CustomColors.kGreen,
      ),
      title: Text(
        text,
        style: const TextStyle(
            color: CustomColors.kBlue, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}
