import 'package:dribbble_clock/pages/home_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  MyHomePage.routeName: ((context) => MyHomePage(
        title: '',
      )),
  // HomePage.routeName: ((context) => const MyHomePage()),
};
