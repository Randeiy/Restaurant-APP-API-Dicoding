import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latihan2_randy/ui/home_page.dart';

class Splash extends StatefulWidget {
  static const routeName = '/splash';
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RestaurantHomePage(),
        ));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFC017),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Please Wait",
              style: TextStyle(fontSize: 20.0, color: Colors.white,fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.amber,
              strokeWidth: 2,
            )
          ],
        ),
      ),
    );
  }
}