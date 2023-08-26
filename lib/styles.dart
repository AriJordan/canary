import 'package:flutter/material.dart';

ButtonStyle elevatedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.black, fontSize: 24)),
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
);
