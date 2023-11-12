import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, [bakg = Colors.red]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(backgroundColor: bakg, content: Text(message)));
  }