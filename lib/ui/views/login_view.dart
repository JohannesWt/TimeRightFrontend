import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/core/constants/app_constants.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/viewmodels/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/login_view_model.dart';

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
          employeeDetailsService: Provider.of(context)),
      child: Column(
        children: <Widget>[Text('Test')],
      ),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            child,
            model.busy
                ? CircularProgressIndicator()
                : FlatButton(
                    child: Text('Login'),
                    onPressed: () async {
                      var fetchedEmployee = await model.login('test1');
                      if (fetchedEmployee != null) {
                        Navigator.pushNamed(context, RoutePaths.homeView);
                      }
                    },
                  )
          ],
        ),
      ),
    );
  }
}
