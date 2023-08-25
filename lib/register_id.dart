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
      appBar: AppBar(
        title: const Text('Phone Verification Code'),
      ),
      body: ReduceWideWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bitte gib deine Canary ID (MAC Addresse) ein',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Pinput(
              length: 12,
              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
              autofocus: true,
              separatorBuilder: (int id) =>
                  id % 2 == 0 ? const Text("-") : const SizedBox(width: 2),
              onChanged: (pin) async {
                if (pin.length == 12) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PhoneNumberScreen(
                            canaryId: _pinPutController.text)),
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
            infoText("Du findest diese auf deinem Canary Gerät")
          ],
        ),
      ),
    );
  }
}
