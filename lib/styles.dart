import 'package:flutter/material.dart';

List<Shadow> textShadowDark = [
  Shadow(
    color: Colors.black.withOpacity(0.8),
    offset: const Offset(1.0, 1.0),
    blurRadius: 2,
  )
];

List<Shadow> textShadowLight = [
  Shadow(
    color: Colors.black.withOpacity(0.2),
    offset: const Offset(1.0, 1.0),
    blurRadius: 2,
  )
];

List<BoxShadow> smallBoxShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 2,
    offset: const Offset(1.0, 1.0),
  ),
];

List<BoxShadow> bigBoxShadow = [
  BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 4,
      offset: const Offset(2.0, 2.0))
];

ButtonStyle elevatedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.black, fontSize: 24)),
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(16)),
);

ButtonStyle redElevatedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white, fontSize: 24)),
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
);

ButtonStyle whiteElevatedButtonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
  textStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(color: Colors.white, fontSize: 24)),
  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
);

const double profilePadding = 8;
int profileImagesWidth = 800;
// Approximate average among Tinder, Bumble, Hinge, OkCupid
double profileImagesWidthToHeightRatio = 1.25;
