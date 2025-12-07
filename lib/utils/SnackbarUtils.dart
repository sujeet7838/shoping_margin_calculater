

import 'package:flutter/material.dart';

class SnackbarUtils {

  var snackBar = SnackBar(
    content: Text(
      ' Please wait, work in progress...',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: const Color.fromARGB(255, 240, 107, 151),
  );


  
  // static showFloatingSnackbar(
  //     String title,
  //     String message, {
  //       Duration duration = const Duration(seconds: 3),
  //       Color backgroundColor = Colors.black,
  //       Color textColor = Colors.white,
  //       SnackPosition position = SnackPosition.BOTTOM,
  //     }) {
  //   Get.snackbar(
  //     title,
  //     message,
  //     duration: duration,
  //     backgroundColor: backgroundColor,
  //     colorText: textColor,
  //     snackPosition: position,
  //     borderRadius: 8,
  //     margin: const EdgeInsets.all(16),
  //     maxWidth: 400,
  //     animationDuration: const Duration(milliseconds: 300),
  //     overlayBlur: 0,
  //     overlayColor: Colors.transparent,
  //     snackStyle: SnackStyle.FLOATING,
  //     mainButton: TextButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       child: Text(
  //         'Dismiss',
  //         style: TextStyle(color: textColor),
  //       ),
  //     ),
  //   );
  // }
}
