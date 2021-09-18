import 'package:client/models/already_asked.dart';
import 'package:client/question_types/multiple_choice_widget.dart';
import 'package:client/screens/home/already_asked_manager.dart';
import 'package:client/screens/home/learn_from_mistakes.dart';
import 'package:client/services/auth.dart';
import 'package:client/services/question_database.dart';
import 'package:client/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  String uid;

  Home({Key key, this.uid}) : super(key:key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // I'm adding a comment here for Advanced Software Engineering
  // Adding another comment
  // Adding another comment
  int index = 0;
  var alreadyAsked = List();

  @override
  Widget build(BuildContext context) {
    print(' ');
    print('in home');

    final model = Provider.of<AlreadyAskedModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Questions'),
          actions: <Widget> [
            FlatButton.icon(
                onPressed: () {
                  setState(() {
                    AuthService().signOut();
                  });
                },
                icon: Icon(Icons.person),
                label: Text('Register'))
          ]
        ),
        body: StreamBuilder(
          stream: QuestionDatabaseService().questionStream,
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Loading();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultipleChoiceWidget(
                mc: QuestionDatabaseService().questionFromSnapshot
                  (snapshot.data.documents[index]),
                next: ({String mistakeCategory}) {
                  print('next question is ${model.nextQuestion()}');
                  if (mistakeCategory == null) {
                    setState(() {index = model.nextQuestion();});
                  }
                  else Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {                       print('index $index');
                      return LearnFromMistakes(
                        mistakeCategory: mistakeCategory,
                        missedQuestion: QuestionDatabaseService()
                            .questionFromSnapshot(snapshot.data.documents[index]),
                        uid: widget.uid,
                      );
                      }
                    )
                  );
                }
              ),
            );
          }
        ),
    );
  }
}
