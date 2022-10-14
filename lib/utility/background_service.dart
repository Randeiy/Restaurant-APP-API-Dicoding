import 'dart:ui';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:latihan2_randy/data/api/api_service.dart';
import 'package:latihan2_randy/main.dart';
import 'package:latihan2_randy/utility/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    // ignore: no_leading_underscores_for_local_identifiers
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().topHeadlines();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}