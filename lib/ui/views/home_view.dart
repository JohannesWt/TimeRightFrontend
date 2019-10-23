import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/widgets/short_overview_card.dart';
import 'package:time_right/ui/widgets/time_stamps_list.dart';
import '../../app_localizations.dart';

class HomeView extends StatefulWidget {
  HomeView({@required int stampFails})
      : _stampFails = stampFails;

  final int _stampFails;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: ShortOverviewCard(),
          ),
          _buildMenuButtons(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TimeStampsList(),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        AppLocalizations.of(context).translate('HOME_TITLE'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: gray4,
          ),
          onPressed: () => Navigator.pushNamed(context, RoutePaths.profileView),
        )
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, RoutePaths.editDataView),
      label: Text(
        AppLocalizations.of(context).translate('HOME_FAB_LABEL'),
        style: TextStyle(fontSize: 20),
      ),
      icon: Icon(
        Icons.input,
        size: 24,
      ),
      backgroundColor: blueAccent,
    );
  }

  Widget _buildMenuButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 5, right: 5),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildMenuButton(
                AppLocalizations.of(context).translate('HOME_CAL_BTN_LABEL'),
                Icons.calendar_today,
                true,
                RoutePaths.calendarView),
            VerticalDivider(
              color: gray4,
              width: 20,
              thickness: 1.2,
            ),
            _buildMenuButton(
                AppLocalizations.of(context).translate('HOME_ABS_BTN_LABEL'),
                Icons.add,
                false,
                RoutePaths.absenceChoiceView),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      String title, IconData icon, bool notificationBatch, String target) {
    return Expanded(
      child: FlatButton(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
          ),
          child: Column(
            children: <Widget>[
              !notificationBatch
                  ? Icon(
                      icon,
                      size: 26,
                    )
                  : Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Icon(
                          icon,
                          size: 26,
                        ),
                        Positioned(
                          right: 0,
                          top: 1,
                          child: widget._stampFails > 0
                              ? Container(
                                  padding: EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      color: mainRed,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  constraints: BoxConstraints(
                                      minWidth: 14, minHeight: 14),
                                  child: Text(
                                    '${widget._stampFails}',
                                    style: TextStyle(fontSize: 8, color: white),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
              Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, target),
      ),
    );
  }
}
