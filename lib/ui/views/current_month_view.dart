import 'package:flutter/material.dart';

class CurrentMonthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'TimeRight',
              style: TextStyle(color: Colors.black, fontSize: 25),
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person, color: Colors.black,),
            onPressed: () => print('Lil'),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 10,
            color: Colors.black38,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text('Test'),
                  Text('Test'),
                  Text('Test'),
                  Text('Test'),
                  Text('Test'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
