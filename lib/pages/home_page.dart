import 'package:dribbble_clock/pages/clock_page.dart';
import 'package:dribbble_clock/pages/stop_watch.dart';
import 'package:dribbble_clock/pages/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home';
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void SetHighs() {}

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[100],
            toolbarHeight: 100.0,
            title: TabBar(
              labelColor: Colors.white,
              isScrollable: true,
              indicatorColor: Colors.amberAccent,
              tabs: [
                Tab(
                  child: Text(
                    'Clock',
                    style: GoogleFonts.dosis(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),

                  // icon: Icon(Icons.alarm_add_sharp),
                ),
                Tab(
                  child: Text(
                    'StopWatch',
                    style: GoogleFonts.dosis(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),

                  // icon: Icon(Icons.alarm_add_sharp),
                ),
                //  icon: Icon(Icons.timelapse)),
                Tab(
                  child: Text(
                    'Timer',
                    style: GoogleFonts.dosis(
                      color: Colors.black,
                      fontSize: 30.0,
                    ),
                  ),

                  // icon: Icon(Icons.alarm_add_sharp),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            ClockPage(),
            StopWatch(),
            Timers(),
          ]),
        ),
      );

  // TODO: implement build

}
