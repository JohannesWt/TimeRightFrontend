/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/app_localizations.dart';
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
                                  ? '${AppLocalizations.of(context).translate('TIME_STAMP_LIST_TODAY_LABEL')} '
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
          if (timeStampEvent.timeStampType == TimeStampType.stampOutFail ||
              timeStampEvent.timeStampType == TimeStampType.stampInFail) {
            return TimeStampsListButtonItem(timeStampEvent: timeStampEvent);
          } else {
            return _buildTimeStampListItem(timeStampEvent);
          }
        });
  }

  /// Build time stamp list item (not a button item)
  Widget _buildTimeStampListItem(TimeStampEvent timeStampEvent) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
      child: _getCorrectItem(timeStampEvent),
    );
  }

  /// Get the correct item class for the time stamp list.
  Widget _getCorrectItem(TimeStampEvent timeStampEvent) {
    if (timeStampEvent.timeStampType == TimeStampType.sickDay ||
        timeStampEvent.timeStampType == TimeStampType.flexDay ||
        timeStampEvent.timeStampType == TimeStampType.vacation) {
      return TimeStampsListAbsenceItem(
        timeStampEvent: timeStampEvent,
      );
    } else if (timeStampEvent.timeStampType ==
            TimeStampType.vacationValidation ||
        timeStampEvent.timeStampType == TimeStampType.flexDayValidation) {
      return TimeStampsListAbsenceValidationItem(
        timeStampEvent: timeStampEvent,
      );
    } else
//      if (timeStampEvent.timeStampType == TimeStampType.stampIn ||
//        timeStampEvent.timeStampType == TimeStampType.stampOut)
    {
      return TimeStampsListStampItem(
        timeStampEvent: timeStampEvent,
      );
    }
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
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(
            _getListTileIcon(),
            color: _getCorrectColor(),
          ),
        ),
        Text(
          _getListTileLabel(context),
          style: TextStyle(color: _getCorrectColor()),
        ),
        Expanded(
          child: Text(
            StringFormatter.getFormattedClockTimeString(
                _timeStampEvent.dateTime),
            style: TextStyle(color: _getCorrectColor()),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  /// Get correct color for [TimeStampType]
  Color _getCorrectColor() {
    if (_timeStampEvent.timeStampType == TimeStampType.stampIn ||
        _timeStampEvent.timeStampType == TimeStampType.stampOut) {
      return black;
    } else {
      return amber;
    }
  }

  /// Return the suitable Label for the list item.
  String _getListTileLabel(BuildContext context) {
    switch (_timeStampEvent.timeStampType) {
      case TimeStampType.stampIn:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_IN');
      case TimeStampType.stampOut:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_OUT');
      case TimeStampType.stampInValidation:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_IN_VALIDATION');
      case TimeStampType.stampOutValidation:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_OUT_VALIDATION');
      default:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_UNKNOWN');
    }
  }

  /// Return the suitable label for the list item.
  IconData _getListTileIcon() {
    switch (_timeStampEvent.timeStampType) {
      case TimeStampType.stampIn:
        return Icons.input;
      case TimeStampType.stampOut:
        return Icons.call_missed_outgoing;
      case TimeStampType.stampInValidation:
        return Icons.input;
      case TimeStampType.stampOutValidation:
        return Icons.call_missed_outgoing;
      default:
        return Icons.unarchive;
    }
  }
}

/// Class of list item for a stamp fail.
class TimeStampsListButtonItem extends StatelessWidget {
  TimeStampsListButtonItem({@required TimeStampEvent timeStampEvent})
      : _timeStampEvent = timeStampEvent;

  final TimeStampEvent _timeStampEvent;

  /// Build a flat button. On click get to the correct stamps view.
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding:
          const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 0, top: 0),
      onPressed: () => Navigator.pushNamed(context, RoutePaths.correctStampView,
          arguments: _timeStampEvent),
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
            _getCorrectLabel(context),
            style: TextStyle(color: mainRed, fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// Get correct label for [TimeStampType]
  String _getCorrectLabel(BuildContext context) {
    if (_timeStampEvent.timeStampType == TimeStampType.stampOutFail) {
      return AppLocalizations.of(context)
          .translate('TIME_STAMP_LIST_ITEM_STAMP_OUT_FAIL');
    } else {
      return AppLocalizations.of(context)
          .translate('TIME_STAMP_LIST_ITEM_STAMP_IN_FAIL');
    }
  }
}

/// Class of a absence stamp list item.
class TimeStampsListAbsenceItem extends StatelessWidget {
  TimeStampsListAbsenceItem({@required TimeStampEvent timeStampEvent})
      : _timeStampEvent = timeStampEvent;

  final TimeStampEvent _timeStampEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: _getCorrectIcon(),
        ),
        Text(_getCorrectLabel(context)),
      ],
    );
  }

  /// Get correct label for [TimeStampType]
  String _getCorrectLabel(BuildContext context) {
    switch (_timeStampEvent.timeStampType) {
      case (TimeStampType.vacation):
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_VAC');
      case (TimeStampType.flexDay):
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_FLEX');
      case (TimeStampType.sickDay):
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_SICK');
      default:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_UNKNOWN');
    }
  }

/// Get correct Icon for [TimeStampType]
  Icon _getCorrectIcon() {
    switch (_timeStampEvent.timeStampType) {
      case (TimeStampType.vacation):
        return Icon(Icons.flight_takeoff);
      case (TimeStampType.flexDay):
        return Icon(Icons.block);
      case (TimeStampType.sickDay):
        return Icon(Icons.local_hospital);
      default:
        return Icon(Icons.unarchive);
    }
  }
}

/// Class of a absence in validation stamp list item.
class TimeStampsListAbsenceValidationItem extends StatelessWidget {
  TimeStampsListAbsenceValidationItem({@required TimeStampEvent timeStampEvent})
      : _timeStampEvent = timeStampEvent;

  final TimeStampEvent _timeStampEvent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(
            _getCorrectIcon(),
            color: amber,
          ),
        ),
        Text(
          _getCorrectLabel(context),
          style: TextStyle(color: amber),
        ),
      ],
    );
  }

  /// Get correct label for [TimeStampType]
  String _getCorrectLabel(BuildContext context) {
    switch (_timeStampEvent.timeStampType) {
      case (TimeStampType.vacationValidation):
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_VAC_APPLY');
      case (TimeStampType.flexDayValidation):
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_FLEX_APPLY');
      default:
        return AppLocalizations.of(context)
            .translate('TIME_STAMP_LIST_ITEM_STAMP_UNKNOWN');
    }
  }

  /// Get correct Icon for [TimeStampType]
  IconData _getCorrectIcon() {
    switch (_timeStampEvent.timeStampType) {
      case (TimeStampType.vacationValidation):
        return Icons.flight_takeoff;
      case (TimeStampType.flexDayValidation):
        return Icons.block;
      default:
        return Icons.unarchive;
    }
  }
}
