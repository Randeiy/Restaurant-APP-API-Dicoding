import 'package:flutter/material.dart';
import 'package:latihan2_randy/data/prefrences/prefrences_dart.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:latihan2_randy/utility/background_service.dart';
import 'package:latihan2_randy/utility/setting_time.dart';


class SchedulProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  SchedulProvider({required this.preferencesHelper}) {
    _getDailyRestaurantPreference();
  }

  bool _isScheduled = true;
  bool get isScheduled => _isScheduled;

  void _getDailyRestaurantPreference() async {
    _isScheduled = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    scheduledRestaurant(value);
    _getDailyRestaurantPreference();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      debugPrint('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}