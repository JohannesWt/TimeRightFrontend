import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/widgets/short_overview_card_model.dart';

import 'work_time_clock.dart';

class ShortOverviewCard extends StatefulWidget {
  @override
  _ShortOverviewCardState createState() => _ShortOverviewCardState();
}

class _ShortOverviewCardState extends State<ShortOverviewCard> {
  ShortOverviewCardModel _shortOverviewCardModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model:
          ShortOverviewCardModel(employeeDetailsService: Provider.of(context)),
      onModelReady: (model) => _shortOverviewCardModel = model,
      builder: (context, model, child) => Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              WorkTimeClock(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: buildShortOverview(),
                ),
              ),
            ],
          ),
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
                '${_shortOverviewCardModel.contractDetails.workHours / 5}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('HOME_CARD_OVERTIME')),
              Text(
                '${_shortOverviewCardModel.currentWorkDetails.flexTime}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('HOME_CARD_LEFT_VAC')),
              Text(
                '${_shortOverviewCardModel.contractDetails.vacation - _shortOverviewCardModel.currentWorkDetails.takenVacation}',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('HOME_CARD_SICK_DAYS')),
              Text(
                '${_shortOverviewCardModel.currentWorkDetails.sickDaysCurrentMonth}',
                textAlign: TextAlign.right,
              )
            ])
          ],
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, RoutePaths.overviewView,
              arguments: _shortOverviewCardModel.employeeDetails),
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
