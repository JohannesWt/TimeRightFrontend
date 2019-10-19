import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_profile/employee_profile.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/login_view_model.dart';
import 'package:time_right/ui/shared/colors.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(
          authenticationService: Provider.of(context),
          employeeDetailsService: Provider.of(context),
          timeStampService: Provider.of(context)),
//      child: Column(
//        children: <Widget>[Text('Test')],
//      ),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              color: amber,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.timer,
                    color: white,
                    size: 40,
                  ),
                  Text(
                    'timeRight',
                    style: TextStyle(color: white, fontSize: 40),
                  ),
                ],
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 220,
//                color: amber,
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
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              controller: model.employeeIDController,
                              decoration: InputDecoration(
                                  hintText: 'Mitarbeiter ID',
                                  icon: Icon(Icons.perm_identity)),
                              cursorColor: blueAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: TextField(
                                controller: model.passwordController,
                                decoration: InputDecoration(
                                    hintText: 'Passwort',
                                    icon: Icon(Icons.lock)),
                                obscureText: true,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          child: Icon(Icons.arrow_forward),
          onPressed: () async {
            Employee employeeProfile = await model.login();
            if (employeeProfile != null) {
              print(employeeProfile.employeeLevel);
              Navigator.pushNamed(context, RoutePaths.homeView,
                  arguments: model.stampFails);
            }
//            .then((value) {
//            }).catchError((error) {
//              print('Fail');
//            });
          },
        ),
      ),
    );
  }
}
