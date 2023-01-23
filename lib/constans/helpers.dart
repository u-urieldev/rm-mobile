import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'dart:math';

class CustomHelpers {
  static Color getStatusColor(String status) {
    if (status == "Alive") {
      return Colors.green;
    }

    if (status == "Dead") {
      return Colors.red;
    }
    // Other case
    return Color.fromARGB(255, 116, 114, 114);
  }

  static Flushbar<dynamic> showCustomSnackBar(
      BuildContext context, String title, String message, Color color) {
    return Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(13),
      title: title,
      titleColor: color,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 3),
    )..show(context);
  }

  static String getRandomCard() {
    final random = new Random();
    final number = random.nextInt(826) + 1;

    return number.toString();
  }
}
