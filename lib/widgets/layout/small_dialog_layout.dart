import 'package:flutter/material.dart';

class SmallDialogLayout extends StatelessWidget {
  SmallDialogLayout({required this.child, super.key});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 270, horizontal: 60),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.black,
          child: child,
        ));
  }
}
