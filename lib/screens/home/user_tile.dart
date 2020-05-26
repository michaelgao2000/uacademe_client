import 'package:flutter/material.dart';
import 'package:client/models/user.dart';

class UserTile extends StatelessWidget {

  final User user;
  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green[user.difficulty]
          ),
          title: Text(user.name),
        ),
      ),
    );
  }
}
