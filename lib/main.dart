import 'package:dribbble_clock/pages/clock_page.dart';
import 'package:dribbble_clock/pages/home_page.dart';
import 'package:dribbble_clock/pages/stop_watch.dart';
import 'package:dribbble_clock/pages/timer_page.dart';
import 'package:dribbble_clock/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: ''),
      routes: routes,
    );
  }
}
