import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'TimeRight',
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          onPressed: () => print('test'),
        )
      ],
    );
  }
}
