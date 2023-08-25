import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import 'package:canary/devices.dart';
import 'package:canary/home.dart';
import 'package:canary/styles.dart';
import 'package:canary/utils.dart';
import 'package:canary/logging.dart';

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
    DevicesChangeNotifier devicesChangeNotifier =
        Provider.of<DevicesChangeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Phone number sign in')),
      ),
      body: ReduceWideWidth(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InternationalPhoneNumberInput(
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
              ),
              ElevatedButton(
                style: elevatedButtonStyle,
                child: const Text('Bestätigen'),
                onPressed: () async {
                  _numberValid = _formKey.currentState!.validate();
                  if (_numberValid) {
                    devicesChangeNotifier.addDeviceValue(
                        widget.canaryId, _currentPhone.phoneNumber!);
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
