import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latihan2_randy/common/navigation.dart';
import 'package:latihan2_randy/utility/notification_helper.dart';
import 'package:latihan2_randy/data/api/api_service.dart';
import 'package:latihan2_randy/data/model/restaurant_list.dart';
import 'package:latihan2_randy/data/prefrences/prefrences_dart.dart';
import 'package:latihan2_randy/provider/database_provider.dart';
import 'package:latihan2_randy/provider/restaurant_list.dart';
import 'package:latihan2_randy/common/style.dart';
import 'package:latihan2_randy/provider/prefrences_provider.dart';
import 'package:latihan2_randy/ui/restaurant_list_page.dart';
import 'package:latihan2_randy/provider/search_restaurant.dart';
import 'package:latihan2_randy/ui/home_page.dart';
import 'package:latihan2_randy/ui/restaurant_detail_page.dart';
import 'package:latihan2_randy/utility/background_service.dart';
import 'package:latihan2_randy/widgets/splash.dart';
import 'package:latihan2_randy/data/db/database_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => RestaurantSearchProvider(apiService: ApiService())),
        ChangeNotifierProvider(
          create: (_) => SchedulProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: secondaryColor,
                onPrimary: Colors.black,
                secondary: secondaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: secondaryColor,
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: Splash.routeName,
        routes: {
          Splash.routeName: (context) => const Splash(),
          RestaurantHomePage.routeName: (context) => const RestaurantHomePage(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurantlist: ModalRoute.of(context)?.settings.arguments
                    as Restaurantlist,
              ),
        },
      ),
    );
  }
}