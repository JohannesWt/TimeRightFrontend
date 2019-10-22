import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/widgets/time_stamps_list_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/date_calculator.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

class TimeStampsList extends StatefulWidget {
  TimeStampsList({
    bool showHeader = true,
  }) : _showHeader = showHeader;

  final _TimeStampsListState _timeStampsListState = _TimeStampsListState();

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
  TimeStampsListModel _timeStampsListModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: TimeStampsListModel(timeStampService: Provider.of(context)),
      onModelReady: (model) {
        _timeStampsListModel = model;
        _timeStampsListModel.setTimeStampEventList();
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

  void _setNextDay() {
    _timeStampsListModel.setNextDay();
  }

  void _setPreviousDay() {
    _timeStampsListModel.setPreviousDay();
  }

  void _setCurrentTimeStampDay(DateTime dateTime) {
    _timeStampsListModel.currentTimeStampDay = dateTime;
  }

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
          return _buildTimeStampItem(
              _timeStampsListModel
                  .currentTimeStampEventList[index].timeStampType,
              StringFormatter.getFormattedClockTimeString(_timeStampsListModel
                  .currentTimeStampEventList[index].dateTime));
        });
  }

  Widget _buildTimeStampItem(TimeStampType timeStampType, String timeString) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: _getListTileIcon(timeStampType),
          ),
          _getListTileLabel(timeStampType),
          Expanded(
              child: Text(
            timeString,
            textAlign: TextAlign.right,
          ))
        ],
      ),
    );
  }

  Icon _getListTileIcon(TimeStampType timeStampType) {
    switch (timeStampType) {
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
      case TimeStampType.stampInFail:
        return Icon(
          Icons.info_outline,
          color: mainRed,
        );
      case TimeStampType.stampOutFail:
        return Icon(
          Icons.info_outline,
          color: mainRed,
        );
      default:
        return Icon(Icons.unarchive);
    }
  }

  Text _getListTileLabel(TimeStampType timeStampType) {
    switch (timeStampType) {
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
      case TimeStampType.stampInFail:
        return Text(
          'Einstempelfehler',
          style: TextStyle(color: mainRed),
        );
      case TimeStampType.stampOutFail:
        return Text(
          'Ausstempelfehler',
          style: TextStyle(color: mainRed),
        );
      default:
        return Text('Unbekanntes Ereignis');
    }
  }
}
