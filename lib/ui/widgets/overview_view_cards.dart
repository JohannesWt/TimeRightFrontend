import 'package:flutter/material.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';

class OverviewCards extends StatefulWidget {
  @override
  _OverviewCardsState createState() => _OverviewCardsState();
}

class _OverviewCardsState extends State<OverviewCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  //how do I call a list of widgets here?
                  child: buildFlexTimeAccount()
                  // buildVacationAccount(),   buildOtherAbsences()
                )),
              ],
            ),
          ),
        ),
        Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        //how do I call a list of widgets here?
                        child: buildVacationAccount()
                      // buildVacationAccount(),   buildOtherAbsences()
                    )),
              ],
            ),
          ),
        ),
        Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: buildOtherAbsences()
                    )),
              ],
            ),
          ),
        ),
      ],

    );
  }

  Widget buildFlexTimeAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('OVERVIEW_CARD1_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_OVER_HOURS')),
              Text(
                '8h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_SHORT_TERM_ACCOUNT')),
              Text(
                '8,5h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_LONG_TERM_ACCOUNT')),
              Text(
                '12',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_OVERTIME_PREV_YEAR')),
              Text(
                '0',
                textAlign: TextAlign.right,
              )
            ])
          ],
        ),
        FlatButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePaths.flexDayView),
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD1_APPLY_FLEXTIME_BTN')),
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

  Widget buildVacationAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('OVERVIEW_CARD2_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_DAYS_CLAIM')),
              Text(
                '8h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_DAYS_PREV_YEAR')),
              Text(
                '8,5h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_TAKEN')),
              Text(
                '12',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_APPLIED')),
              Text(
                '0',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_PLAN')),
              Text(
                '0',
                textAlign: TextAlign.right,
              )
            ])
          ],
        ),
        FlatButton(
          onPressed: () =>
              Navigator.pushNamed(context, RoutePaths.vacationView),
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: <Widget>[
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD2_VAC_APPLY_BTN')),
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

  Widget buildOtherAbsences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('OVERVIEW_CARD3_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.25)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD3_SICK_DAYS')),
              Text(
                '8h',
                textAlign: TextAlign.right,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('OVERVIEW_CARD3_PUBLIC_HOLIDAYS')),
              Text(
                '8,5h',
                textAlign: TextAlign.right,
              )
            ]),
          ],
        ),
      ],
    );
  }
}
