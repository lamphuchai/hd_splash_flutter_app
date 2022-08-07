import 'package:flutter/material.dart';

SnackBar customSnackBar(String message) {
  return SnackBar(
    duration: const Duration(milliseconds: 500),
    content: Text(message),
  );
}
