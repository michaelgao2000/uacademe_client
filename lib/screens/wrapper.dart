import 'package:client/models/user.dart';
import 'package:client/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
