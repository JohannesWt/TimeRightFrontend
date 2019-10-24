/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/ui/views/base_widget.dart';
import 'package:time_right/core/viewmodels/widgets/time_stamps_list_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/date_calculator.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

/// Class builds list with [TimeStampEvent] of a certain day.
class TimeStampsList extends StatefulWidget {
  TimeStampsList({
    bool showHeader = true,
  }) : _showHeader = showHeader;

  final _TimeStampsListState _timeStampsListState = _TimeStampsListState();

  /// Decides if the header, displaying the date and the previous and forward
  /// button is shown.
  final bool _showHeader;

  void setNextDay() {
    _timeStampsListState._setNextDay();
  }

  void setPreviousDay() {
    _timeStampsListState._setPreviousDay();
  }

  void setCurrentTimeStampDay(DateTime dateTime) {
    _timeStampsListState._setCurrentTimeStampDay(dateTime);
  }

  @override
  _TimeStampsListState createState() => _timeStampsListState;
}

class _TimeStampsListState extends State<TimeStampsList> {
  /// [TimeStampsListModel] handles the business logic of this widget.
  TimeStampsListModel _timeStampsListModel;

  /// Builds the header, displaying the day and prev- next- buttons and the
  /// list of [TimeStampEvent].
  @override
  Widget build(BuildContext context) {
    return BaseWidget<TimeStampsListModel>(
      model: TimeStampsListModel(timeStampService: Provider.of(context)),
      onModelReady: (model) {
        _timeStampsListModel = model;
        _timeStampsListModel.setCurrentTimeStampEventList();
      },
      builder: (context, model, child) => Column(
        children: <Widget>[
          widget._showHeader
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          _timeStampsListModel.setPreviousDay();
                        },
                      ),
                      FlatButton.icon(
                        label: Text(
                          (DateCalculator.isOnSameDay(
                                      _timeStampsListModel.currentTimeStampDay,
                                      DateTime.now())
                                  ? 'Heute '
                                  : '') +
                              StringFormatter.getFormattedShortDateString(
                                  _timeStampsListModel.currentTimeStampDay),
                          style: Theme.of(context).textTheme.title,
                        ),
                        icon: Icon(Icons.today),
                        onPressed: () {
                          _timeStampsListModel.currentTimeStampDay =
                              DateTime.now();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          _timeStampsListModel.setNextDay();
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          Expanded(child: _buildTimeStampList())
        ],
      ),
    );
  }

  /// Set the displayed day and list of [TimeStampEvent] to the next day after
  /// the current displayed day.
  void _setNextDay() {
    _timeStampsListModel.setNextDay();
  }

  /// Set the displayed day and list of [TimeStampEvent] to the previous day before
  /// the current displayed day.
  void _setPreviousDay() {
    _timeStampsListModel.setPreviousDay();
  }

  /// Set current displayed day and list of [TimeStampEvent] to a specified day.
  void _setCurrentTimeStampDay(DateTime dateTime) {
    _timeStampsListModel.currentTimeStampDay = dateTime;
  }

  /// Return a list of TimeStampEventListItems [_timeStampsListModel.currentTimeStampEventList].
  Widget _buildTimeStampList() {
    return ListView.separated(
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0),
              child: Divider(
                color: gray4,
              ),
            ),
        itemCount: _timeStampsListModel.currentTimeStampEventList.length,
        itemBuilder: (BuildContext context, int index) {
          TimeStampEvent timeStampEvent =
              _timeStampsListModel.currentTimeStampEventList[index];
          if (timeStampEvent.timeStampType == TimeStampType.stampOutFail) {
            return TimeStampsListButtonItem(timeStampEvent: timeStampEvent);
          } else {
            return TimeStampsListStampItem(
              timeStampEvent: timeStampEvent,
            );
          }
        });
  }
}

/// Class builds a single Item in the TimeStampList.
class TimeStampsListStampItem extends StatelessWidget {
  TimeStampsListStampItem({@required TimeStampEvent timeStampEvent})
      : _timeStampEvent = timeStampEvent;

  final TimeStampEvent _timeStampEvent;

  /// Build a list item.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: _getListTileIcon(),
          ),
          _getListTileLabel(),
          _isTimeVisible()
              ? Expanded(
                  child: Text(
                    StringFormatter.getFormattedClockTimeString(
                        _timeStampEvent.dateTime),
                    textAlign: TextAlign.right,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  /// Return the suitable Label for the list item.
  Text _getListTileLabel() {
    switch (_timeStampEvent.timeStampType) {
      case TimeStampType.stampIn:
        return Text('Einstempeln');
      case TimeStampType.stampOut:
        return Text('Ausstempeln');
      case TimeStampType.flexDay:
        return Text('Gleittag');
      case TimeStampType.vacation:
        return Text('Urlaub');
      case TimeStampType.sickDay:
        return Text('Kranktag');
      default:
        return Text('Unbekanntes Ereignis');
    }
  }

  /// Return the suitable label for the list item.
  Icon _getListTileIcon() {
    switch (_timeStampEvent.timeStampType) {
      case TimeStampType.stampIn:
        return Icon(Icons.input);
      case TimeStampType.stampOut:
        return Icon(Icons.call_missed_outgoing);
      case TimeStampType.flexDay:
        return Icon(Icons.block);
      case TimeStampType.vacation:
        return Icon(Icons.flight_takeoff);
      case TimeStampType.sickDay:
        return Icon(Icons.local_hospital);
      default:
        return Icon(Icons.unarchive);
    }
  }

  /// Return if the stamp time should be visible or not.
  /// (E.g. a list item displaying a flex day should not display the stamp
  /// time of it)
  bool _isTimeVisible() {
    return (_timeStampEvent.timeStampType == TimeStampType.stampOut ||
        _timeStampEvent.timeStampType == TimeStampType.stampIn);
  }
}

/// Builds a list item for a stamp fail.
class TimeStampsListButtonItem extends StatelessWidget {
  TimeStampsListButtonItem({@required TimeStampEvent timeStampEvent})
      : _timeStampEvent = timeStampEvent;

  final TimeStampEvent _timeStampEvent;

  /// Build a flat button. On click get to the correct stamps view.
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding:
      const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0, top: 0),
      onPressed: () =>
          Navigator.pushNamed(context, RoutePaths.absenceChoiceView),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
              Icons.info_outline,
              color: mainRed,
            ),
          ),
          Text(
            'Ausstempelfehler',
            style: TextStyle(color: mainRed, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
