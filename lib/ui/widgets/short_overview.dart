import 'package:flutter/material.dart';
import 'package:time_right/ui/shared/colors.dart';

class ShortOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: gray3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Übersicht',
                    style: TextStyle(fontSize: 20, color: white),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios,
                            size: 20, color: white),
                        onPressed: () => print('Übersicht'),
                      ),
                    ),
                  )
                ],
              ),
              buildShortOverviewTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShortOverviewTable() {
    const bottomPadding = 12.0;
    return Table(
      children: [
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: bottomPadding),
            child: Text(
              'Überstunden Monat:',
              style: TextStyle(color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: bottomPadding),
            child: Text(
              '7.5',
              style: TextStyle(color: white),
            ),
          )
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: bottomPadding),
            child: Text(
              'Kranktage Monat:',
              style: TextStyle(color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: bottomPadding),
            child: Text(
              '2',
              style: TextStyle(color: white),
            ),
          )
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: bottomPadding),
            child: Text(
              'Urlaubstage Monat:',
              style: TextStyle(color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: bottomPadding),
            child: Text(
              '5',
              style: TextStyle(color: white),
            ),
          )
        ]),
        TableRow(children: [
          Text(
            'Resturlaub:',
            style: TextStyle(color: white),
          ),
          Text(
            '15',
            style: TextStyle(color: white),
          )
        ]),
      ],
    );
  }
}
