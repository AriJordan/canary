import 'package:canary/register_phone.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'package:canary/utils.dart';
import 'package:canary/logging.dart';

// Screen to enter device id
class RegisterIdScreen extends StatefulWidget {
  const RegisterIdScreen({super.key});

  @override
  RegisterIdScreenState createState() => RegisterIdScreenState();
}

class RegisterIdScreenState extends State<RegisterIdScreen> {
  var log = logger(RegisterIdScreenState);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final TextEditingController _pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log.i("Building verify_code screen");
    return Scaffold(
      key: _scaffoldkey,
      appBar: titleBarWidget(),
      body: ReduceWideWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bitte gib deine Canary ID (MAC Addresse) ein',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 16,
            ),
            Pinput(
              length: 12,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
              autofocus: true,
              separatorBuilder: (int id) =>
                  id % 2 == 1 ? const Text(" - ") : const SizedBox(width: 2),
              onChanged: (pin) async {
                if (pin.length == 12) {
                  String canaryId = "";
                  for (int i = 0; i < _pinPutController.text.length; i++) {
                    canaryId += _pinPutController.text[i];
                    if (i % 2 == 1 && i != _pinPutController.text.length - 1) {
                      canaryId += "-";
                    }
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PhoneNumberScreen(canaryId: canaryId)),
                  );
                }
              },
              onSubmitted: (pin) async {
                if (pin.length == 12) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhoneNumberScreen(
                            canaryId: _pinPutController.text)),
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            infoText("Du findest diese auf deinem Canary Gerät")
          ],
        ),
      ),
    );
  }
}
