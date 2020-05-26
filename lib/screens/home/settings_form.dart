import 'package:client/models/auth_user.dart';
import 'package:client/models/client_user.dart';
import 'package:client/services/user_database.dart';
import 'package:client/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:client/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName = 'Name';
  int _currentDifficulty = 5;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser>(context);
    print('in settings');
    print(user.uid);
    print(' ');

    return StreamBuilder<ClientUser>(
      stream: UserDatabaseService(uid: user.uid).thisUser,
      builder: (context, snapshot) {
        if(snapshot.hasData == true) {
          return Form(
            key: _formKey,
            child: Column(
                children: <Widget>[
                  Text(
                      'Update your profile.',
                      style: TextStyle(fontSize: 18)
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                    initialValue: snapshot.data.name,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20),
                  Slider(
                    min: 0,
                    max: 900,
                    divisions: 10,
                    activeColor: Colors.blueAccent,
                    inactiveColor: Colors.redAccent,
                    value: (_currentDifficulty ?? snapshot.data.difficulty).toDouble(),
                    onChanged: (difficulty) {
                      setState(() => _currentDifficulty = difficulty.round());
                    },
                  ),
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        await UserDatabaseService(uid: snapshot.data.uid).updateUserData(_currentName, _currentDifficulty);
                      }
                  )
                ]
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
