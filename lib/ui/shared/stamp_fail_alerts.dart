/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Show alert if the employee has to stamp out first, when the employee wanted
/// to stamp in but is still stamped in.
class StampOutFirstFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stempelfehler'),
      content: Text('Zuerst ausstempeln'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert if the employee has to stamp in first, when the employee wanted
/// to stamp out but is already stamped out.
class StampInFirstFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stempelfehler'),
      content: Text('Zuerst einstempeln'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert if the employee is not allowed to stamp any event, in order there
/// is a vacation already stamped in.
class StampVacationFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stempelfehler'),
      content: Text('Es liegt ein Urlaub vor'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert if the employee is not allowed to stamp any event, in order there
/// is a flex day already stamped in.
class StampFlexDayFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stempelfehler'),
      content: Text('Es liegt ein Gleittag vor'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}


/// Show alert for unknown errors
class UnknownStampTypeFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stempelfehler'),
      content: Text('Unbekannter Fehler'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

/// Show alert for unknown errors
class WorkDayFailAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Stempelfehler'),
      content: Text('Am Wochenende kann nicht gestempelt werden'),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
