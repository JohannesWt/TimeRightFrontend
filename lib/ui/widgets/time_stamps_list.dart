import 'package:flutter/material.dart';

class TimeStampsList extends StatefulWidget {
  @override
  _TimeStampsListState createState() => _TimeStampsListState();
}

class _TimeStampsListState extends State<TimeStampsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {},
                  ),
                  FlatButton.icon(
                    label: Text('Heute, 28.09.2019', style: Theme.of(context).textTheme.title,),
                    icon: Icon(Icons.today),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  buildTimeStampItem('Ausstempeln', Icons.input, '16:45:23'),
                  buildTimeStampItem('Einstempeln', Icons.input, '13:05:45'),
                  buildTimeStampItem('Ausstempeln', Icons.input, '12:16:05'),
                  buildTimeStampItem('Einstempeln', Icons.input, '07:45:23'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTimeStampItem(String title, IconData icon, String time) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 6.0, bottom: 6.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(icon),
          ),
          Text(title),
          Expanded(
              child: Text(
            time,
            textAlign: TextAlign.right,
          ))
        ],
      ),
    );
  }
}
