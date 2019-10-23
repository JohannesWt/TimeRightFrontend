import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_right/ui/widgets/profileview_list.dart';
import 'package:time_right/core/constants/app_constants.dart';

import '../../app_localizations.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ProfileList(),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        AppLocalizations.of(context).translate('PROFILE_TITLE'),
      ),
    );
  }
}