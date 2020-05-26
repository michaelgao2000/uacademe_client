import 'package:client/screens/home/settings_form.dart';
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

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(),
        );
      });
    }

    final users = Provider.of<List<ClientUser>>(context) ?? [];

    return StreamBuilder<AuthUser>(
      stream: null,
      builder: (context, snapshot) {
        return StreamProvider<List<ClientUser>>.value(
          value: UserDatabaseService().users,
          initialData: List(),
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
                  ),
                  FlatButton.icon(
                    onPressed: () {_showSettingsPanel();},
                    icon: Icon(Icons.settings),
                    label: Text('Settings')
                  )
                ],
              ),
              body: UserList(),
            )
          ),
        );
      }
    );
  }
}
