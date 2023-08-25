import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Limit width to at most (height / 1.8)
double widthLimit(BuildContext context) {
  return min(MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height / 1.8);
}

// Avoid layout being too wide on wide screens.
// The idea is to apply it to all screens (except maybe chat) for a more consistent format.
class ReduceWideWidth extends StatelessWidget {
  final Widget child;
  const ReduceWideWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widthLimit(context),
        child: Padding(
            // `bottom` more to let user scroll down a bit further down to see there is nothing left
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
            child: child),
      ),
    );
  }
}

Row infoText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.info_outline_rounded),
      const SizedBox(width: 8),
      Flexible(
        child: Text(text),
      ),
    ],
  );
}

Center titleWidget() {
  return Center(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/blue_canary.png', height: 40),
      Text(
        "Canary",
        style: GoogleFonts.roboto(color: Colors.black),
        textScaleFactor: 2.4,
      ),
    ],
  ));
}
