import 'dart:math';

import 'package:flutter/material.dart';

class WorkTimeClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.0,
      width: 135.0,
      child: CustomPaint(
        foregroundPainter: HoursDrawer(
            lineColor: Colors.amber,
            completeColor: Colors.blueAccent,
            completePercent: 80,
            width: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Arbeitszeit:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '5:45:23',
              style: TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}

class HoursDrawer extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;

  HoursDrawer(
      {this.lineColor, this.completeColor, this.completePercent, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min((size.width - width) / 2, (size.height - width) / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
