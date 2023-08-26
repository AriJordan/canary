import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:canary/edit.dart';
import 'package:canary/styles.dart';
import 'package:canary/register_id.dart';
import 'package:canary/canaries.dart';
import 'package:canary/logging.dart';
import 'package:canary/utils.dart';

Align getAddButton(BuildContext context) {
  var log = logger(ElevatedButton);
  log.i('Trying to get user');
  return Align(
    alignment: Alignment.center,
    child: FloatingActionButton(
      onPressed: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterIdScreen()),
        );
      },
      child: const Icon(Icons.add),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final String title = 'Canary';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final log = logger(HomeScreenState);

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
              for (MapEntry mapEntry in devicesChangeNotifier.devices.entries) {
                devices.add(
                  ElevatedButton(
                    style: elevatedButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditScreen(
                                  canaryId: mapEntry.key,
                                  phoneNumber: mapEntry.value,
                                )),
                      );
                    },
                    child: Column(
                      children: [
                        iconText(Icons.memory, "Canary ID: ${mapEntry.key}"),
                        iconText(
                            Icons.phone, "Telefonnummer: ${mapEntry.value}"),
                      ],
                    ),
                  ),
                );
                devices.add(const SizedBox(height: 4));
                devices.add(const Text(
                  "Anklicken zum ändern",
                  style: TextStyle(color: Colors.grey),
                ));
                devices.add(const SizedBox(height: 16));
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Registrierte Canary Geräte",
                    textScaleFactor: 2.0,
                  ),
                  const SizedBox(height: 16),
                  ...devices,
                  getAddButton(context),
                  const SizedBox(height: 16),
                  infoText(
                      'Du kannst mehrmals das gleiche Canary Gerät oder die gleiche Telefonnummer registrieren'),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
