import 'package:flutter/material.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';

import 'work_time_clock.dart';

class ShortOverviewCard extends StatefulWidget {
  @override
  _ShortOverviewCardState createState() => _ShortOverviewCardState();
}

class _ShortOverviewCardState extends State<ShortOverviewCard> {
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
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: buildShortOverview(),
            )),
          ],
        ),
      ),
    );
  }

  Widget buildShortOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('HOME_CARD_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_WORK_TIME')),
              Text(
                '8h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('HOME_CARD_OVERTIME')),
              Text(
                '8,5h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('HOME_CARD_LEFT_VAC')),
              Text(
                '12',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_SICK_DAYS')),
              Text(
                '0',
                textAlign: TextAlign.right,
              )
            ])
          ],
        ),
        FlatButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePaths.overviewView),
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_OVERVIEW_BTN')),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios)))
            ],
          ),
        ),
      ],
    );
  }
}
