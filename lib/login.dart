import 'package:flutter/material.dart';

import 'account.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
            child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            'What\'s up, Chewbee?',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20.0),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email Address")),
          TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password")),
          SizedBox(height: 20.0),
          RaisedButton(
            child: Text("LOGIN"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            },
          )
        ])));
  }
}
