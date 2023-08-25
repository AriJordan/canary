import 'package:flutter/material.dart';

import 'package:canary/register_id.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canary',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const RegisterIdScreen(),
    );
  }
}
