/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/ui/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/profile_view_model.dart';
import 'package:time_right/ui/widgets/profile_list.dart';

import '../../app_localizations.dart';

/// Class builds the profile view
class ProfileView extends StatelessWidget {
  /// Build the profile view with the [ProfileList].
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileViewModel>(
      model: ProfileViewModel(
          authenticationService: Provider.of(context),
          timeStampService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).translate('PROFILE_TITLE'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await model.logOut();
                Navigator.pushNamed(context, RoutePaths.loginView);
              },
            )
          ],
        ),
        body: ProfileList(),
      ),
    );
  }
}
