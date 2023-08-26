import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import 'package:canary/canaries.dart';
import 'package:canary/home.dart';
import 'package:canary/styles.dart';
import 'package:canary/utils.dart';
import 'package:canary/logging.dart';

Future showSuccess(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erfolg'),
          content: const Text(
              'Canary Gerät und Telefonnummer erfolgreich registriert'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Super'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

class PhoneNumberScreen extends StatefulWidget {
  final String canaryId;
  const PhoneNumberScreen({super.key, required this.canaryId});

  @override
  PhoneNumberScreenState createState() => PhoneNumberScreenState();
}

class PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final log = logger(PhoneNumberScreenState);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber _currentPhone = PhoneNumber(isoCode: "CH");
  bool _numberValid = true;

  // `phoneNumber` must have non-null members `phoneNumber` and `dialCode`
  String getLocalNumber(PhoneNumber phoneNumber) {
    assert(phoneNumber.phoneNumber != null);
    assert(phoneNumber.dialCode != null);
    // Both without '+'
    return phoneNumber.phoneNumber!
        .replaceAll('+', '')
        .substring(phoneNumber.dialCode!.replaceAll('+', '').length);
  }

  @override
  Widget build(BuildContext context) {
    CanariesChangeNotifier devicesChangeNotifier =
        Provider.of<CanariesChangeNotifier>(context);
    return Scaffold(
      appBar: titleBarWidget(),
      body: ReduceWideWidth(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InternationalPhoneNumberInput(
                formatInput: false,
                onInputChanged: (PhoneNumber number) async {
                  log.d("Phone number input changed");
                  if (mounted) {
                    _currentPhone = number;
                  }
                  if (mounted && !_numberValid) {
                    _numberValid = _formKey.currentState!.validate();
                  }
                },
                ignoreBlank: true,
                inputBorder: const OutlineInputBorder(),
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                initialValue: _currentPhone,
                hintText: "Telefonnummer",
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: elevatedButtonStyle,
                child: const Text('Bestätigen'),
                onPressed: () async {
                  log.d(_currentPhone.phoneNumber);
                  _numberValid = _formKey.currentState!.validate() || true;
                  log.d("_numberValid: $_numberValid");
                  if (_numberValid) {
                    devicesChangeNotifier.addCanaryValue(
                        widget.canaryId, _currentPhone.phoneNumber!);
                    showSuccess(context);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
