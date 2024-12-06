
import 'package:flutter/material.dart';

void showSnackBarWidget(BuildContext context , String message , Color color){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message),
    backgroundColor: color,
    padding: const EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    ));
}