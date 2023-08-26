import 'package:canary/register_id.dart';
import 'package:canary/register_phone.dart';
import 'package:canary/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:canary/canaries.dart';
import 'package:canary/logging.dart';
import 'package:canary/styles.dart';

Align getChangeButton(BuildContext context, String key) {
  return Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhoneNumberScreen(canaryId: key)),
        );
      },
      style: elevatedButtonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.phone,
            size: 26,
          ),
          SizedBox(width: 4),
          Text('Telefonnummer ändern')
        ],
      ),
    ),
  );
}

Align getDeleteButton(BuildContext context, String key) {
  CanariesChangeNotifier devicesChangeNotifier =
      Provider.of<CanariesChangeNotifier>(context);
  return Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () async {
        devicesChangeNotifier.deleteCanary(key);
        Navigator.pop(context);
      },
      style: elevatedButtonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.delete,
            size: 26,
          ),
          SizedBox(width: 4),
          Text('Gerät Löschen')
        ],
      ),
    ),
  );
}

class EditScreen extends StatefulWidget {
  final String canaryId;
  final String phoneNumber;
  const EditScreen(
      {super.key, required this.canaryId, required this.phoneNumber});

  final String title = 'Canary';

  @override
  EditScreenState createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  final log = logger(EditScreenState);

  @override
  Widget build(BuildContext context) {
    CanariesChangeNotifier devicesChangeNotifier =
        Provider.of<CanariesChangeNotifier>(context);
    return Scaffold(
      appBar: titleBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: ReduceWideWidth(
            child: Builder(builder: (context) {
              List<Widget> devices = [];
              for (MapEntry mapEntry
                  in devicesChangeNotifier.canaries.entries) {
                devices.add(
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterIdScreen()),
                        );
                      },
                      child: Text('${mapEntry.key} ${mapEntry.value}'),
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  const Text(
                    "Canary Gerät anpassen",
                    textScaleFactor: 2.0,
                  ),
                  const SizedBox(height: 8),
                  iconText(
                      const Icon(
                        Icons.memory,
                        size: 26,
                      ),
                      "ID: ${widget.canaryId}"),
                  const SizedBox(height: 24),
                  ElevatedButton(
                      style: elevatedButtonStyle,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PhoneNumberScreen(canaryId: widget.canaryId)),
                        );
                      },
                      child: iconText(
                          const Icon(
                            Icons.phone,
                            size: 26,
                          ),
                          widget.phoneNumber)),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Anklicken zum ändern",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  getDeleteButton(context, widget.canaryId),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
