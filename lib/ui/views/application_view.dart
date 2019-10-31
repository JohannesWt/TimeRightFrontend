/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/models/time_stamp_details/time_stamp_details.dart';
import 'package:time_right/core/viewmodels/views/application_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/views/base_widget.dart';

class ApplicationView extends StatefulWidget {
  @override
  _ApplicationViewState createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView>
    with SingleTickerProviderStateMixin {
  ApplicationViewModel _applicationViewModel;

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ApplicationViewModel>(
      model: ApplicationViewModel(timeStampService: Provider.of(context)),
      onModelReady: (model) => {
        _applicationViewModel = model,
        _applicationViewModel.setLists(),
      },
      child: AppBar(
        title: Text('Anträge'),
      ),
      builder: (context, model, child) => Scaffold(
        appBar: child,
        body: Column(
          children: <Widget>[
            TabBar(
              controller: _tabController,
              tabs: <Widget>[
                _buildTabTitle(Icons.timer),
                _buildTabTitle(Icons.flight_takeoff),
                _buildTabTitle(Icons.block),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _buildTabForList(
                      _applicationViewModel.timeStampApplicationList),
                  _buildTabForList(
                      _applicationViewModel.vacationApplicationsList),
                  _buildTabForList(_applicationViewModel.flexDayApplicationList)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabTitle(IconData iconData) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Icon(iconData, color: gray4),
    );
  }

  Widget _buildTabForList(List<TimeStampEvent> tmpList) {
    return AnimatedList(
      initialItemCount: tmpList.length,
      itemBuilder: (context, index, animation) {
        return Column(
          children: <Widget>[
            ApplicationListItem(
              timeStampEvent: tmpList[index],
              applicationViewModel: _applicationViewModel,
            ),
            index < tmpList.length - 1
                ? Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(color: gray4),
                  )
                : Container(),
          ],
        );
      },
    );
  }
}

class ApplicationListItem extends StatelessWidget {
  ApplicationListItem(
      {@required TimeStampEvent timeStampEvent,
      @required ApplicationViewModel applicationViewModel})
      : _timeStampEvent = timeStampEvent,
        _applicationViewModel = applicationViewModel;

  final TimeStampEvent _timeStampEvent;
  final ApplicationViewModel _applicationViewModel;

  @override
  Widget build(BuildContext context) {
    bool isAbsence =
        _timeStampEvent.timeStampType == TimeStampType.flexDayValidation ||
            _timeStampEvent.timeStampType == TimeStampType.vacationValidation;
    print(isAbsence);
    return Padding(
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          isAbsence
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(_getCorrectIcon()),
                ),
          isAbsence ? _buildAbsenceContainer() : _buildStampContainer(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(Icons.cancel, color: red1, size: 35),
                  onPressed: () async {
                    int index =
                        _applicationViewModel.getIndexOfItem(_timeStampEvent);
                    await _applicationViewModel.proveApplication(
                        _timeStampEvent, 'declined');
                    AnimatedList.of(context).removeItem(index,
                        (context, animation) {
                      return FadeTransition(
                        opacity: CurvedAnimation(
                            parent: animation, curve: Interval(0.5, 1.0)),
                        child: SizeTransition(
                          sizeFactor: CurvedAnimation(
                              parent: animation, curve: Interval(0.0, 1.0)),
                          axisAlignment: 0.0,
                          child: ApplicationListItem(
                              timeStampEvent: _timeStampEvent,
                              applicationViewModel: _applicationViewModel),
                        ),
                      );
                    });
                  },
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: green1,
                  size: 35,
                ),
                onPressed: () async {
                  int index =
                      _applicationViewModel.getIndexOfItem(_timeStampEvent);
                  await _applicationViewModel.proveApplication(
                      _timeStampEvent, 'proved');
                  AnimatedList.of(context).removeItem(index,
                      (context, animation) {
                    return FadeTransition(
                      opacity: CurvedAnimation(
                          parent: animation, curve: Interval(0.5, 1.0)),
                      child: SizeTransition(
                        sizeFactor: CurvedAnimation(
                            parent: animation, curve: Interval(0.0, 1.0)),
                        axisAlignment: 0.0,
                        child: ApplicationListItem(
                            timeStampEvent: _timeStampEvent,
                            applicationViewModel: _applicationViewModel),
                      ),
                    );
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  IconData _getCorrectIcon() {
    if (_timeStampEvent.timeStampType == TimeStampType.stampOutValidation) {
      return Icons.call_missed_outgoing;
    } else {
      return Icons.input;
    }
  }

  Widget _buildAbsenceContainer() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Antragsteller:',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            _timeStampEvent.employeeName,
            textScaleFactor: 1.1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Datum:'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            StringFormatter.getFormattedShortDateString(
              _timeStampEvent.dateTime,
            ),
            textScaleFactor: 1.1,
          ),
        )
      ],
    ));
  }

  Widget _buildStampContainer() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Antragsteller:',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            _timeStampEvent.employeeName,
            textScaleFactor: 1.1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Datum:'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            StringFormatter.getFormattedShortDateString(
              _timeStampEvent.dateTime,
            ),
            textScaleFactor: 1.1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('Uhrzeit:'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            StringFormatter.getFormattedClockTimeString(
              _timeStampEvent.dateTime,
            ),
            textScaleFactor: 1.1,
          ),
        )
      ],
    ));
  }
}
