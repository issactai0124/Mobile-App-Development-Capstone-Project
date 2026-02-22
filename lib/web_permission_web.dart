import 'dart:js_interop';
import 'package:web/web.dart' as web;

Future<bool> requestWebNotificationPermission() async {
  final permission = await web.Notification.requestPermission().toDart;
  return permission.toDart == 'granted';
}

void showWebNotification(String title, String body) {
  web.Notification(title, web.NotificationOptions(body: body));
}
