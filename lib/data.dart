import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:canary/logging.dart';

class CanariesData {
  final log = logger(CanariesData);

  final CollectionReference canariesCollection =
      FirebaseFirestore.instance.collection('canaries');

  Future<void> saveCanaryPhonenumber(
      String canaryId, String phoneNumber) async {
    log.i("Saving phoneNumber for canary ...");

    await canariesCollection
        .doc(canaryId)
        .collection('phoneNumbers')
        .add({'phoneNumber': phoneNumber});

    log.i("Finished saving phoneNumber");
    return Future<void>.value();
  }
}
