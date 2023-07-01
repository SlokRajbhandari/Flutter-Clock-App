import 'dart:async';

import 'package:dribbble_clock/clock_news/clock_view.dart';
import 'package:dribbble_clock/clock_news/hour_pointer.dart';
import 'package:dribbble_clock/clock_news/minute_pointer.dart';
import 'package:dribbble_clock/clock_news/second_pointer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPlaying = false;
  double progress = 1.0;
  int minutes = 0, seconds = 0, hours = 0;
  String digitseconds = "00", digiMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    void notify() {
      if (countText == '0:00:00') {
        FlutterRingtonePlayer.playNotification();
      }
    }

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //making the reset in the timer

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digiMinutes = "00";
      digitHours = "00";
      digitseconds = "00";
      started = false;
      laps = [];
    });
  }

  void addLaps() {
    String lap = "$digitHours:$digiMinutes:$digitseconds";
    setState(() {
      laps.add(lap);
    });
  }

// to start the application
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localseconds = seconds + 1;
      int localminutes = minutes;
      int localhours = hours;

      if (localseconds == 59) {
        localseconds = 0;
        localminutes = localminutes + 1;
        if (localminutes == 59) {
          localhours = localhours + 1;
          localminutes = 0;
          localseconds = 0;
        }
      }
      setState(() {
        seconds = localseconds;
        hours = localhours;
        minutes = localminutes;
        digitseconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digiMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const pi = 3.14;

    final height = MediaQuery.of(context).size.height;
    final minute = digiMinutes;
    final angleMinute = (-pi * (minutes / -60)) * 2;
    final second = digitseconds;
    final hour = digitHours;
    final angle = (-pi * (hours / -12)) * 2;
    final angleSecond = (-pi * (seconds / -60)) * 2;
    final width = MediaQuery.of(context).size.width;
    bool isPortait = height > width;
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

                    RotatedBox(
                      quarterTurns: 2,
                      child: Transform.rotate(
                        angle: angleSecond,
                        child: Transform.translate(
                          offset: Offset(0, 34),
                          child: Center(
                            child: Container(
                              height: isPortait ? height * 0.10 : width * 0.10,
                              width: 2,
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //this is the rotated box for the hour pointer can be added after : )
                    // RotatedBox(
                    //   quarterTurns: 2,
                    //   child: Transform.rotate(
                    //     angle: angle,
                    //     child: Transform.translate(
                    //       offset: Offset(0, 20),
                    //       child: Center(
                    //         child: Container(
                    //           height: isPortait ? height * 0.06 : width * 0.06,
                    //           width: 4,
                    //           decoration: BoxDecoration(
                    //             color: Colors.black,
                    //             borderRadius: BorderRadius.circular(32),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Transform.rotate(
                        angle: angleMinute,
                        child: Transform.translate(
                          offset: Offset(0, 30),
                          child: Center(
                            child: Container(
                              height: isPortait ? height * 0.07 : width * 0.00,
                              width: 4,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Image.asset(
                      'assets/images/clock_hel2.png',
                      height: 200,
                      width: 200,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$digitHours:$digiMinutes:$digitseconds",
                    style: GoogleFonts.montserrat(
                      fontSize: 33.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RawMaterialButton(
                        constraints: BoxConstraints.tight(Size(70, 55)),
                        child: Icon(Icons.flag),
                        fillColor: Colors.grey[200],
                        shape: CircleBorder(),
                        onPressed: () {
                          addLaps();
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RawMaterialButton(
                          constraints: BoxConstraints.tight(Size(70, 55)),
                          onPressed: () {
                            reset();
                            controller.reset();
                            setState(
                              () {
                                isPlaying = false;
                              },
                            );
                          },
                          fillColor: Colors.grey[200],
                          shape: CircleBorder(),
                          child: Icon(Icons.restart_alt),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          (!started) ? start() : stop();
          if (controller.isAnimating) {
            controller.stop();
            setState(() {
              isPlaying = false;
            });
          } else {
            controller.reverse(
                from: controller.value == 0 ? 1.0 : controller.value);
            setState(() {
              isPlaying = true;
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 300,
          child: ListView.builder(
              itemCount: laps.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Lap ${index + 1}",
                            style: GoogleFonts.dosis(
                              color: Colors.black,
                              fontSize: 22.0,
                            )),
                        Text("${laps[index]}",
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
