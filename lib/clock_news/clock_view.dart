import 'package:flutter/material.dart';

class AnalogicCircle extends StatelessWidget {
  const AnalogicCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isPortait = height > width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: isPortait ? height * 0.235 : height * 0.6,
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 10.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(-4, -4),
                blurRadius: 15,
                spreadRadius: 5.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
