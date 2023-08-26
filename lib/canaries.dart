import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:canary/data.dart';
import 'package:canary/logging.dart';

// To update and get canaries and their associated phonenumbers from different screens
class CanariesChangeNotifier extends ChangeNotifier {
  final log = logger(CanariesChangeNotifier);
  final LinkedHashMap<String, String> _canaries = LinkedHashMap();

  LinkedHashMap<String, String> get canaries => _canaries;

  void addCanaryValue(String key, String value) {
    log.d("Updating device $key to $value");
    _canaries[key] = value;
    notifyListeners();
    CanariesData().saveCanaryPhonenumber(key, value);
  }

  void deleteCanary(String key) {
    log.d("Deleting device $key");
    _canaries.remove(key);
    notifyListeners();
    // TODOaj: Delete in database
  }
}
