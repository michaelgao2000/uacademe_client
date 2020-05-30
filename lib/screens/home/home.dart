import 'package:client/question_types/multiple_choice_template.dart';
import 'package:client/question_types/multiple_choice_widget.dart';
import 'package:client/services/question_database.dart';
import 'package:client/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/screens/home/question_builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions')
      ),
      body: StreamBuilder(
        stream: QuestionDatabaseService().questionStream,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Loading();
          return MultipleChoiceWidget(
            mc: QuestionDatabaseService().questionFromSnapshot
              (snapshot.data.documents[index]),
            next: () {
              setState(() => index += 1);
            }
          );
        }
      ),
    );
  }
}
