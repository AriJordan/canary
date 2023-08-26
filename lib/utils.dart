import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Limit width to at most (height / 1.8)
double widthLimit(BuildContext context) {
  return min(MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height / 1.8);
}

// Avoid layout being too wide on wide screens.
class ReduceWideWidth extends StatelessWidget {
  final Widget child;
  const ReduceWideWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widthLimit(context),
        child: Padding(
            // Always some nice padding
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 50),
            child: child),
      ),
    );
  }
}

Padding infoText(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info_outline_rounded),
        const SizedBox(width: 8),
        Flexible(
          child: Text(text),
        ),
      ],
    ),
  );
}

AppBar titleBarWidget() {
  return AppBar(
    title: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/blue_canary.png', height: 40),
        const SizedBox(width: 4),
        Text(
          "Canary",
          style: GoogleFonts.roboto(color: Colors.black),
          textScaleFactor: 2.4,
        ),
        const SizedBox(
          width: 8,
        )
      ],
    )),
    centerTitle: true,
  );
}

Row iconText(Icon icon, String text) {
  return Row(mainAxisSize: MainAxisSize.min, children: [
    icon,
    const SizedBox(
      width: 4,
    ),
    Text(text)
  ]);
}
