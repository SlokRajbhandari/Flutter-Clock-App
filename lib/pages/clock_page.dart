import 'dart:ffi';

import 'package:dribbble_clock/clock_news/clock_view.dart';
import 'package:dribbble_clock/clock_news/hour_pointer.dart';
import 'package:dribbble_clock/clock_news/minute_pointer.dart';
import 'package:dribbble_clock/clock_news/second_pointer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClockPage extends StatefulWidget {
  ClockPage({Key? key}) : super(key: key);

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    return formattedDate;
  }

  getCurrentTime() {
    var hour = DateTime.now().hour.toString();
    var sec = DateTime.now().second.toString();
    var min = DateTime.now().minute.toString();

    var fulltime = '$hour hour, $min minutes and $sec seconds';
    return fulltime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Stream.periodic(
          Duration(seconds: 1),
        ),
        builder: (context, snapshot) {
          return SingleChildScrollView(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnalogicCircle(),
                  MinutePointer(),
                  HourPointer(),
                  SecondPointer(),
                  Image.asset(
                    'assets/images/analogclock2.png',
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
              SizedBox(
                height: 22.0,
              ),
              Text(getCurrentDate(),
                  style: GoogleFonts.montserrat(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Text(getCurrentTime(),
                  style: GoogleFonts.dosis(fontSize: 22, color: Colors.black))
            ],
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 300,
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${index + 1} London",
                        style: GoogleFonts.dosis(
                          color: Colors.black,
                          fontSize: 22.0,
                        )),
                    Text("12:45",
                        style: GoogleFonts.dosis(
                          color: Colors.black,
                          fontSize: 30.0,
                        )),
                  ],
                ));
          }),
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

