
import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:canary/logging.dart';

// To update and get devices from different screens
class DevicesChangeNotifier extends ChangeNotifier {
  final log = logger(DevicesChangeNotifier);
  String uid;
  final LinkedHashMap<String, String> _devices;
  // Upload devices also in beginning
  // bool _devicesNeedUpdate = true;
  // bool _devicesUpdating = false;

  DevicesChangeNotifier(
      {required this.uid, required LinkedHashMap<String, String> devices})
      : _devices = devices {
    log.d("Rebuilding devicesChangeNotifier");
  }

  LinkedHashMap<String, String> get devices => _devices;

  void addDeviceValue(String key, String value) {
    log.d("Updating device $key to $value");
    _devices[key] = value;
    // _devicesNeedUpdate = true;
    notifyListeners();
    updatedevices();
  }

  void deleteDevice(String key) {
    log.d("Deleting device $key");
    _devices.remove(key);
    // _devicesNeedUpdate = true;
    notifyListeners();
    updatedevices();
  }

  // Update user's desired devices if needed and not already updating
  // Not intended to be `await`ed
  // TODOaj: implement
  Future<void> updatedevices() async {
    // log.i("Maybe updating user's devices");
    // log.d(_devices);
    // if (_devicesNeedUpdate && !_devicesUpdating) {
    //   _devicesUpdating = true;
    //   while (_devicesNeedUpdate) {
    //     log.i("Updating user's devices ...");
    //     _devicesNeedUpdate = false;
    //     try {
    //       await devicesData(uid: uid).updatedevices(Completedevices(_devices));
    //       log.i("Updated user's devices");
    //     } catch (e, stackTrace) {
    //       log.e("$e, $stackTrace");
    //     }
    //   }
    //   _devicesUpdating = false;
    // }
  }
}
