import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/widgets/time_stamps_list_model.dart';
import 'package:time_right/ui/shared/string_formatter.dart';

class TimeStampsList extends StatefulWidget {
  @override
  _TimeStampsListState createState() => _TimeStampsListState();
}

class _TimeStampsListState extends State<TimeStampsList> {
  TimeStampsListModel _timeStampsListModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: TimeStampsListModel(employeeDetailsService: Provider.of(context)),
      onModelReady: (model) {
        _timeStampsListModel = model;
        _timeStampsListModel.setTimeStampDay(DateTime.now());
      },
      builder: (context, model, child) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        _timeStampsListModel.getPreviousTimeStampDay();
                      },
                    ),
                    FlatButton.icon(
                      label: Text(
                        (_timeStampsListModel.currentTimeStampDay ==
                                    _timeStampsListModel.todayTimeStampDay
                                ? 'Heute '
                                : '') +
                            StringFormatter.getFormattedShortDateString(
                                _timeStampsListModel.currentTimeStampDay.date),
                        style: Theme.of(context).textTheme.title,
                      ),
                      icon: Icon(Icons.today),
                      onPressed: () {
                        _timeStampsListModel.setTimeStampDay(DateTime.now());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        _timeStampsListModel.getNextTimeStampDay();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: buildTimeStampList())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeStampList() {
    return ListView.builder(
        itemCount: _timeStampsListModel.currentTimeStampEventList.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTimeStampItem(
              _timeStampsListModel
                  .currentTimeStampEventList[index].timeStampType,
              Icons.input,
              StringFormatter.getFormattedClockTimeString(_timeStampsListModel
                  .currentTimeStampEventList[index].dateTime));
        });
  }

  Widget buildTimeStampItem(TimeStampType type, IconData icon, String time) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(icon),
          ),
          Text(getListTileLabel(type)),
          Expanded(
              child: Text(
            time,
            textAlign: TextAlign.right,
          ))
        ],
      ),
    );
  }

  String getListTileLabel(TimeStampType type) {
    switch (type) {
      case TimeStampType.stampIn:
        return "Einstempeln";
      case TimeStampType.stampOut:
        return "Ausstempeln";
      case TimeStampType.flexDay:
        return "Gleittag";
      case TimeStampType.vacation:
        return "Urlaub";
      case TimeStampType.sickDay:
        return "Kranktag";
      default:
        return "Unbekanntes Ereignis";
    }
  }
}
