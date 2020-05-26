import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[75],
        appBar: AppBar(
          title: Text('uAcadeMe'),
          backgroundColor: Colors.brown[500],
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Log out'),
            )
          ],
        )
      )
    );
  }
}
