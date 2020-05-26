import 'package:client/services/auth.dart';
import 'package:client/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/screens/home/user_list.dart';
import 'package:client/models/client_user.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ClientUser>>.value(
      value: UserDatabaseService().users,
      child: Container(
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
          ),
          body: UserList(),
        )
      ),
    );
  }
}
