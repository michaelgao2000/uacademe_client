import 'package:client/screens/home/home.dart';
import 'package:client/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user.dart';
import 'package:client/models/user.dart';
import 'package:client/screens/authenticate/authenticate.dart';
import 'package:client/screens/home/learn_from_mistakes.dart';
import 'package:client/screens/home/already_asked_manager.dart';
import 'package:client/models/already_asked.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AlreadyAskedModel>(
      create: (context) => AlreadyAskedModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: AuthService().user,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Authenticate();
            } else {
              // return LearnFromMistakes(mistakeCategory: 'Algebra', uid: snapshot.data.uid);
              // return UserLanding();
              return Home(uid: snapshot.data.uid);
            }
          },
        ),
      ),
    );

    /* return StreamProvider<User>.value(
      value: AuthService().user,
      initialData: User(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    ); */
  }
}

