import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == _notifications) return;
    setState(() {
      _notifications = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: const Text("Enable notifications"),
            value: _notifications,
            onChanged: _onNotificationsChanged,
          ),
          CheckboxListTile(
            title: const Text("Enable notifications"),
            activeColor: Colors.black,
            value: _notifications,
            onChanged: _onNotificationsChanged,
          ),
          const AboutListTile(),
          ListTile(
            title: const Text("What is your birthday"),
            onTap: () async {
              // final date = await showDatePicker(
              //   context: context,
              //   firstDate: DateTime(1980),
              //   lastDate: DateTime(2030),
              // );
              // print(date);
              // final time = await showTimePicker(
              //   context: context,
              //   initialTime: TimeOfDay.now(),
              // );
              // print(time);
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(
                      appBarTheme: const AppBarTheme(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              print(range);
            },
          ),
          ListTile(
            title: const Text('Log out (iOS)'),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text('Are you sure?'),
                  message: const Text('please don go'),
                  actions: [
                    CupertinoActionSheetAction(
                      isDefaultAction: true,
                      onPressed: () {},
                      child: const Text('Not log out'),
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () {},
                      child: const Text('Yes plz'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
