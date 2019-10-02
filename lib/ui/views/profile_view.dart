import 'package:flutter/material.dart';
import 'package:time_right/core/constants/app_constants.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilinformationen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Navigator.pushNamed(context, RoutePaths.loginView),
          )
        ],
      ),
    );
  }
}