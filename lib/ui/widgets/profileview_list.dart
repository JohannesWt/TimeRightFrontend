import 'package:flutter/material.dart';
import 'package:time_right/app_localizations.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
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
                  child: profileInformation(),
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
                    child: profileBankDetails(),
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
                    child: profileInsuranceDetails(),
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
                    child: profileCompanyDetails(),
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget profileInformation() {
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
            TableRow(children: [
              Text(
                  AppLocalizations.of(context).translate('PROFILE_FIRST_NAME')),
              Text(
                'Lightning',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_LAST_NAME')),
              Text(
                'McQueen',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_DOB')),
              Text(
                '01.01.2000',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_EMAIL')),
              Text(
                'lightning@thunder.com',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_PHONE')),
              Text(
                '080022222222',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_ADDRESS')),
              Text(
                'Radiator Springs 66 7777 California',
                textAlign: TextAlign.left,
              )
            ])
          ],
        ),
      ],
    );
  }

  Widget profileBankDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppLocalizations.of(context).translate('PROFILE_BANK_TITLE'),
          style: Theme.of(context).textTheme.title,
        ),
        Table(columnWidths: {1: FractionColumnWidth(.6)},
          children: [
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_BANK_RECIPIENT')),
              Text(
                'Lightning McQueen',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_BANK_IBAN')),
              Text(
                'DE76 3333 5555 7777 9999 20',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context).translate('PROFILE_BANK_NAME')),
              Text(
                'Tow Mater Bank',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_BANK_VALID_FROM')),
              Text(
                '12.12.2022',
                textAlign: TextAlign.left,
              )
            ])
          ],
        ),
      ],
    );
  }

  Widget profileInsuranceDetails() {
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
                'RiskItForTheBuiscuit',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_INSURANCE_STATUS')),
              Text(
                'General Fund',
                textAlign: TextAlign.left,
              )
            ]),
          ],
        ),
      ],
    );
  }

  Widget profileCompanyDetails() {
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
                'Lightning McQueens Racing Academy',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_COMPANY_POSITION')),
              Text(
                'Big Boss',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_COMPANY_SUPERIOR')),
              Text(
                'Nodbody',
                textAlign: TextAlign.left,
              )
            ]),
            TableRow(children: [
              Text(AppLocalizations.of(context)
                  .translate('PROFILE_COMPANY_DIVISION')),
              Text(
                'Racing',
                textAlign: TextAlign.left,
              )
            ])
          ],
        ),
      ],
    );
  }
}
