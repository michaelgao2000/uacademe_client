import 'package:client/models/already_asked.dart';
import 'package:client/question_types/multiple_choice_widget.dart';
import 'package:client/screens/home/already_asked_manager.dart';
import 'package:client/screens/home/learn_from_mistakes.dart';
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
  int index = 0;
  var alreadyAsked = List();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AlreadyAskedModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Questions')
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
                  // TODO IDEA add no reptition (or do it in the questionDB stream??)
                  if(mistakeCategory == null) {
                    for(int x in model.alreadyAsked) {
                      if(QuestionDatabaseService().questionFromSnapshot
                        (snapshot.data.documents[index]).docId == x) {
                        setState(() => index += 2);
                      }
                    }
                    setState(() => index += 1);
                  } else Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LearnFromMistakes(
                        mistakeCategory: mistakeCategory,
                        missedQuestion: QuestionDatabaseService()
                            .questionFromSnapshot(snapshot.data.documents[index]),
                        uid: widget.uid,
                      )
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
