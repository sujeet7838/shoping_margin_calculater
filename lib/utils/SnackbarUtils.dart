

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
}
