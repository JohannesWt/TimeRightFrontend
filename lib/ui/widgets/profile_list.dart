/*
 * Copyright (c) 2019. Julian Börste, Nico Kindervater, Steffen Montag, Chris McQueen, Johannes Wiest. All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_right/app_localizations.dart';
import 'package:time_right/core/models/employee/employee.dart';
import 'package:time_right/core/models/employee_profile/employee_profile.dart';
import 'package:time_right/ui/shared/string_formatter.dart';
import 'package:time_right/ui/views/base_widget.dart';
import 'package:time_right/core/viewmodels/views/profile_view_model.dart';
import 'package:time_right/ui/views/profile_view.dart';

/// Class builds the profile list displayed in the [ProfileView].
class ProfileList extends StatelessWidget {
  ProfileList({@required EmployeeProfile employeeProfile})
      : _employeeProfile = employeeProfile;

  final EmployeeProfile _employeeProfile;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  //how do I call a list of widgets here?
                  child: _profileInformation(context),
                )),
              ],
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    //how do I call a list of widgets here?
                    child: _profileBankDetails(context),
                  )),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    //how do I call a list of widgets here?
                    child: _profileInsuranceDetails(context),
                  )),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    //how do I call a list of widgets here?
                    child: _profileCompanyDetails(context),
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Return Column with personal information of the current logged in employee
  Widget _profileInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('PROFILE_INFO'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.6)},
          children: [
//            TableRow(children: [
//              Text(
//                  AppLocalizations.of(context).translate('PROFILE_FIRST_NAME')),
//              Text(
//                '${_employeeProfile.firstName}',
//                textAlign: TextAlign.left,
//              )
//            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_LAST_NAME')),
              Text(
                '${_employeeProfile.lastName}',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_DOB')),
              Text(
                '${StringFormatter.getFormattedShortDateString(_employeeProfile.dateOfBirth)}',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_EMAIL')),
              Text(
                '${_employeeProfile.emailAddress}',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_PHONE')),
              Text(
                '${_employeeProfile.phoneNumber}',
                textAlign: TextAlign.left,
              )
            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context).translate('PROFILE_ADDRESS')),
//              Text(
//                '${_employeeProfile.address.street}, ${_employeeProfile.address.houseNr}\n ${_employeeProfile.address.postCode} ${_employeeProfile.address.city}',
//                textAlign: TextAlign.left,
//              )
//            ])
          ],
        ),
      ],
    );
  }

  /// Return column of bank details information of the current logged in employee
  Widget _profileBankDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('PROFILE_BANK_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.6)},
          children: [
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('PROFILE_BANK_RECIPIENT')),
//              Text(
//                '${_employeeProfile.bankDetails.receiver}',
//                textAlign: TextAlign.left,
//              )
//            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_BANK_IBAN')),
              Text(
                '${_employeeProfile.bankDetails.iBAN}',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_BANK_NAME')),
              Text(
                '${_employeeProfile.bankDetails.bankName}',
                textAlign: TextAlign.left,
              )
            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('PROFILE_BANK_VALID_FROM')),
//              Text(
//                '${_employeeProfile.bankDetails.validFrom}',
//                textAlign: TextAlign.left,
//              )
//            ])
          ],
        ),
      ],
    );
  }

  /// Return column with insurance details of the current logged in employee
  Widget _profileInsuranceDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('PROFILE_INSURANCE_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.6)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_INSURANCE_NAME')),
              Text(
                '${_employeeProfile.insuranceDetails.name}',
                textAlign: TextAlign.left,
              )
            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('PROFILE_INSURANCE_STATUS')),
//              Text(
//                '${_employeeProfile.insuranceDetails}',
//                textAlign: TextAlign.left,
//              )
//            ]),
          ],
        ),
      ],
    );
  }

  /// Return column with company details (department, position) of the current
  /// logged in employee
  Widget _profileCompanyDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('PROFILE_COMPANY_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(
          columnWidths: {1: FractionColumnWidth(.6)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_COMPANY_Name')),
              Text(
                '${_employeeProfile.companyDetails.companyName}',
                textAlign: TextAlign.left,
              )
            ]),
//            TableRow(children: [
//              Text(AppLocalizations.of(context)
//                  .translate('PROFILE_COMPANY_POSITION')),
//              Text(
//                '${_employeeProfile.companyDetails.}',
//                textAlign: TextAlign.left,
//              )
//            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_COMPANY_SUPERIOR')),
              Text(
                '${_employeeProfile.companyDetails.department.executiveName}',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_COMPANY_DIVISION')),
              Text(
                '${_employeeProfile.companyDetails.department.departmentName}',
                textAlign: TextAlign.left,
              )
            ])
          ],
        ),
      ],
    );
  }
}
