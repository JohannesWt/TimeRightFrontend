import 'package:flutter/material.dart';
import 'package:time_right/ui/shared/home_app_bar.dart';
import 'package:time_right/ui/widgets/short_overview.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar().build(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
           ShortOverview(),
          ],
        ),
      ),
    );
  }
}
