import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:canary/register_id.dart';
import 'package:canary/devices.dart';
import 'package:canary/logging.dart';
import 'package:canary/utils.dart';

Align getAddButton(BuildContext context) {
  var log = logger(ElevatedButton);
  log.i('Trying to get user');
  return Align(
    alignment: Alignment.center,
    child: IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterIdScreen()),
        );
      },
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
                getAddButton(context),
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
