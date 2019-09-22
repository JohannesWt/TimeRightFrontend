import 'package:flutter/material.dart';
import 'package:time_right/ui/widgets/short_overview.dart';

import 'work_time_clock.dart';

class ShortOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            WorkTimeClock(),
            Expanded(child: ShortOverview()),
          ],
        ),
      ),
    );
  }
}
