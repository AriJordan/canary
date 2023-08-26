import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:canary/canaries.dart';
import 'package:canary/register_id.dart';

// Wrapper deciding which screen to show based on authentication
class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();
}

class _WrapperScreenState extends State<WrapperScreen> {
  // Return either Authenticate, Onboarding or Home screen
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CanariesChangeNotifier>(
          create: (context) => CanariesChangeNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Canary',
        builder: FToastBuilder(),
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const RegisterIdScreen(),
      ),
    );
  }
}
