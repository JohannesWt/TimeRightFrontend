/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/ui/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/login_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';

/// Class build the login view.
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  /// Building the login view, referencing the [LoginViewModel] to handle the
  /// login process.
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(
          authenticationService: Provider.of(context),
          employeeDetailsService: Provider.of(context),
          timeStampService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return Future.value(false);
          },
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                color: amber,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'TimeRight\u{00AE}',
                      style: TextStyle(color: white, fontSize: 44),
                    ),
                  ],
                )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 220,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('LOGIN_VIEW_WELCOME_LABEL'),
                          style: TextStyle(
                            fontSize: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  TextField(
                                    controller: model.employeeIDController,
                                    decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context).translate('LOGIN_VIEW_WELCOME_FORM_ID'),
                                        icon: Icon(Icons.perm_identity)),
                                    cursorColor: blueAccent,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: TextField(
                                      controller: model.passwordController,
                                      decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context).translate('LOGIN_VIEW_WELCOME_FORM_PASSWORD'),
                                          icon: Icon(Icons.lock)),
                                      obscureText: true,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
//                              child: CircularProgressIndicator(),
                                child: model.busy
                                    ? CircularProgressIndicator()
                                    : Container(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          child: Icon(Icons.arrow_forward),
          onPressed: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            Employee employeeProfile = await model.login().catchError((error) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Fehler'),
                      content:
//                          Text(error.toString()),
                          Text('Beim Einloggen ist ein Fehler aufgetreten'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('ok'),
                          onPressed: () {
                            model.setBusy(false);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            });
            if (employeeProfile != null) {
              print(employeeProfile.employeeLevel);
              await model.getEmployeeDetails();
              await model.getTimeStampsForMonth(DateTime.now());
              if (employeeProfile.employeeLevel == EmployeeLevel.executive) {
                model.getExecutiveDetails();
              }
              Navigator.pushNamed(context, RoutePaths.homeView,
                  arguments: model.employeeDetails);
            }
          },
        ),
      ),
    );
  }
}
