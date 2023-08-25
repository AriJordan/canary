import 'package:canary/register_id.dart';
import 'package:canary/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:canary/devices.dart';
import 'package:canary/logging.dart';
import 'package:canary/styles.dart';

Align getDeleteButton(BuildContext context, String key) {
  //var log = logger(ElevatedButton);
  DevicesChangeNotifier devicesChangeNotifier =
      Provider.of<DevicesChangeNotifier>(context);
  return Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () async {
        devicesChangeNotifier.devices.remove(key);
      },
      style: elevatedButtonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.logout,
            size: 26,
          ),
          SizedBox(width: 4),
          Text('Löschen')
        ],
      ),
    ),
  );
}

class EditScreen extends StatefulWidget {
  final String canaryId;
  const EditScreen({super.key, required this.canaryId});

  final String title = 'Canary';

  @override
  EditScreenState createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {
  final log = logger(EditScreenState);

  @override
  Widget build(BuildContext context) {
    DevicesChangeNotifier devicesChangeNotifier =
        Provider.of<DevicesChangeNotifier>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          textScaleFactor: 2,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ReduceWideWidth(
          child: Builder(builder: (context) {
            List<Widget> devices = [];
            for (MapEntry mapEntry in devicesChangeNotifier.devices.entries) {
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
                ...devices,
                const SizedBox(height: 8),
                getDeleteButton(context, widget.canaryId),
                infoText(
                    'Du kannst mehrmals das gleiche Gerät oder die gleiche Nummer registrieren'),
              ],
            );
          }),
        ),
      ),
    );
  }
}
