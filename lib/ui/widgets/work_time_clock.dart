import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/widgets/work_time_clock_model.dart';
import 'package:time_right/ui/shared/colors.dart';

class WorkTimeClock extends StatefulWidget {
  @override
  _WorkTimeClockState createState() => _WorkTimeClockState();
}

class _WorkTimeClockState extends State<WorkTimeClock> {
  WorkTimeClockModel _workTimeClockModel;

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose');
    _workTimeClockModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return BaseWidget(
      model: WorkTimeClockModel(
          employeeDetailsService: Provider.of(context),
          timeStampService: Provider.of(context)),
      onModelReady: (model) {
        _workTimeClockModel = model;
        _workTimeClockModel.startWorkTimer();
      },
      builder: (context, model, child) => Container(
        height: 135.0,
        width: 135.0,
        child: CustomPaint(
          foregroundPainter: HoursDrawer(
              lineColor: amber,
              completeColor: blueAccent,
              completePercent: _workTimeClockModel.percentage,
              width: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Arbeitszeit:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                _workTimeClockModel.workHoursString,
                style: TextStyle(fontSize: 28),
              ),
            ],
          ),
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
    double arcAngle = 2 * pi * (completePercent);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
