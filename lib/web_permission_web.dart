import 'dart:js_interop';
import 'package:web/web.dart' as web;

Future<void> requestWebNotificationPermission() async {
  final permission = await web.Notification.requestPermission().toDart;
  print('Web Notification Permission result: ${permission.toDart}');
}
