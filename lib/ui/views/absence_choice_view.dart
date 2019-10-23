import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../app_localizations.dart';

class AbsenceChoiceView extends StatelessWidget {
  AbsenceChoiceView({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:Text(
            AppLocalizations.of(context).translate('HOME_ABS_BTN_LABEL'))),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            FlatButton(
                onPressed: () {},
               child: Row(
                  children: <Widget>[
                    Text("Urlaub beantragen ",textScaleFactor: 1.3),
                    Expanded(

                        child: Align(

                            alignment: Alignment.centerRight,

                            child: Icon(Icons.arrow_forward_ios)))
                  ],
                )
            ),
            FlatButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Text("Gleittag beantragen ",textScaleFactor: 1.3),
                    Expanded(

                        child: Align(

                            alignment: Alignment.centerRight,

                            child: Icon(Icons.arrow_forward_ios)))
                  ],
                )
            ),
            FlatButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Text("Krankmeldung ",textScaleFactor: 1.3),
                    Expanded(

                        child: Align(

                            alignment: Alignment.centerRight,

                            child: Icon(Icons.arrow_forward_ios)))
                  ],
                )
            )
          ],
        )
    );
  }


}

