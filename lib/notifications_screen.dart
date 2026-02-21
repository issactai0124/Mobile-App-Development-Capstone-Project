import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool notificationsEnabled = false;
  List<String> selectedHabits = [];
  List<String> selectedTimes = [];
  Map<String, String> allHabitsMap = {};
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _loadData();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    // Ensure you have an app icon (e.g., @mipmap/ic_launcher) configured in Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    // FIX: initializationSettings is a positional argument, but the user IDE reports it requires a named parameter 'settings'.
    // However, looking at the standard package, it IS positional.
    // BUT the user's error message says: "The named parameter 'settings' is required".
    // This implies the user has a version or custom wrapper where it IS named.
    // I will try to use the named parameter 'settings' as the error suggests.
    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {},
    );
  }
  // WAIT. I cannot write comments inside the function call in the file.
  // I will just write the code.
  // Re-reading error: "The named parameter 'settings' is required".
  // So I will use `settings: initializationSettings`.

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? false;
      allHabitsMap = Map<String, String>.from(
        jsonDecode(prefs.getString('selectedHabitsMap') ?? '{}'),
      );
      selectedHabits = prefs.getStringList('notificationHabits') ?? [];
      selectedTimes = prefs.getStringList('notificationTimes') ?? [];
    });
  }

  Future<void> _saveNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', notificationsEnabled);
    await prefs.setStringList('notificationHabits', selectedHabits);
    await prefs.setStringList('notificationTimes', selectedTimes);
  }

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor'; // Add opacity if not included.
    }
    return Color(int.parse('0x$hexColor'));
  }

  Future<void> _sendTestNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'habit_tracker_channel',
          'Habit Reminders',
          channelDescription: 'Channel for habit notifications',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    // FIX: User error says "The named parameter 'id' is required... 0 positional expected, 4 found".
    // So I MUST use named parameters for id, title, body, notificationDetails.
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Habit Reminder',
      body: "It's time to work on your habits!",
      notificationDetails: notificationDetails,
      payload: 'test',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
                _saveNotificationSettings();
              },
            ),
            const Divider(),
            const Text(
              'Select Habits for Notification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: allHabitsMap.entries.map((entry) {
                final habit = entry.key;
                final colorHex = entry.value;
                final color = _getColorFromHex(colorHex);
                return FilterChip(
                  label: Text(habit),
                  labelStyle: TextStyle(color: color),
                  selected: selectedHabits.contains(habit),
                  selectedColor: color.withOpacity(0.3),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: color, width: 2.0),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedHabits.add(habit);
                      } else {
                        selectedHabits.remove(habit);
                      }
                    });
                    _saveNotificationSettings();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Times for Notification',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: ['Morning', 'Afternoon', 'Evening'].map((time) {
                return FilterChip(
                  label: Text(time),
                  selected: selectedTimes.contains(time),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedTimes.add(time);
                      } else {
                        selectedTimes.remove(time);
                      }
                    });
                    _saveNotificationSettings();
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                _sendTestNotification();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Send Test Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
