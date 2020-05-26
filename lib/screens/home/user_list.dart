import 'package:client/models/client_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/screens/home/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<ClientUser>>(context) ?? [];

    return ListView.builder(
      itemBuilder: (context, index) {
        return UserTile(user: users[index]);
      },
      itemCount: users.length,
    );
  }
}
