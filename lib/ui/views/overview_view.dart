import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/ui/shared/colors.dart';
import 'package:time_right/ui/widgets/overview_view_cards.dart';

import '../../app_localizations.dart';

class OverviewView extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<OverviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: OverviewCards(),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate('OVERVIEW_TITLE'),
      ),
    );
  }
}
