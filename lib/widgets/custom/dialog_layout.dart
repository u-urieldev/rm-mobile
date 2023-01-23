import 'package:flutter/material.dart';

class DialogLayout extends StatelessWidget {
  const DialogLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: Container(
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
