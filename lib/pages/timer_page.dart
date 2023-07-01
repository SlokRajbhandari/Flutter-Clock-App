import 'dart:async';

import 'package:dribbble_clock/clock_news/hour_pointer.dart';
import 'package:dribbble_clock/clock_news/minute_pointer.dart';
import 'package:dribbble_clock/clock_news/second_pointer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../clock_news/clock_view.dart';

class Timers extends StatefulWidget {
  @override
  State<Timers> createState() => _TimersState();
}

class _TimersState extends State<Timers> with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      FlutterRingtonePlayer.playNotification();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //   @override
  // Widget build(BuildContext context) {

  // Timer? timer;
  // @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  //   reset();
  // }

  // void reset() {
  //   if (isCountdown) {
  //     setState(() => duration = countDownDuration);
  //   } else {
  //     setState(() {
  //       duration = Duration();
  //     });
  //   }
  // }

  // void addTime() {
  //   final addSecond = isCountdown ? -1 : 1;

  //   setState(() {
  //     final seconds = duration.inSeconds + addSecond;
  //     if (seconds < 0) {
  //       timer?.cancel();
  //     } else {
  //       duration = Duration(seconds: seconds);
  //     }
  //   });
  // }

  // startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  // }
  // Duration duration

  // Widget buildTime() {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   final hours = twoDigits(duration.inHours.remainder(60));
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       buildTimeCard(time: hours, header: 'HOURS'),
  //       const SizedBox(width: 8),
  //       buildTimeCard(time: minutes, header: 'MINUTES'),
  //       const SizedBox(width: 8),
  //       buildTimeCard(time: seconds, header: 'SECONDS'),
  //     ],
  //   );
  // }

  // Widget buildTimeCard({required String time, required String header}) =>
  //     Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(12.0),
  //           decoration: BoxDecoration(
  //               color: Colors.black, borderRadius: BorderRadius.circular(10)),
  //           child: Text(time,
  //               style: GoogleFonts.dosis(
  //                 color: Colors.white,
  //                 fontSize: 45.0,
  //               )),
  //         ),
  //         const SizedBox(
  //           height: 8.0,
  //         ),
  //         Text(header)
  //       ],
  //     );

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
                    'assets/images/timer.png',
                    height: 210,
                    width: 210,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey.shade300,
                        value: progress,
                        strokeWidth: 6,
                      ),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  if (controller.isDismissed) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        height: 300,
                        child: CupertinoTimerPicker(
                          initialTimerDuration: controller.duration!,
                          onTimerDurationChanged: (time) {
                            setState(() {
                              controller.duration = time;
                            });
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) => Text(
                      countText,
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),

              // Center(
              //   child: buildTime(),
              // ),
            ],
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
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
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 25, 300, 200),
            child: RawMaterialButton(
              onPressed: () {
                // if (controller.isDismissed) {
                //   showModalBottomSheet(
                //     context: context,
                //     builder: (context) => Container(
                //       height: 300,
                //       child: CupertinoTimerPicker(
                //         initialTimerDuration: controller.duration!,
                //         onTimerDurationChanged: (time) {
                //           setState(() {
                //             controller.duration = time;
                //           });
                //         },
                //       ),
                //     ),
                //   );
                // }
                // reset();
                controller.reset();
                setState(
                  () {
                    isPlaying = false;
                  },
                );
              },
              shape: CircleBorder(),
              child: Icon(Icons.restart_alt),
              fillColor: Colors.grey[200],
            ),
          ),
        ),
      ),
    );
  }
}
