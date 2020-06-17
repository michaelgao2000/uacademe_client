import 'package:client/models/already_asked.dart';
import 'package:client/question_types/multiple_choice_widget.dart';
import 'package:client/question_types/multiple_choice_template.dart';
import 'package:client/services/question_database.dart';
import 'package:client/services/user_database.dart';
import 'package:client/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user.dart';
import 'package:client/services/auth.dart';


class LearnFromMistakes extends StatefulWidget {

  final String mistakeCategory;
  final MultipleChoice missedQuestion;
  final String uid;

  LearnFromMistakes({Key key, this.mistakeCategory, this.uid,
    this.missedQuestion}) : super(key:key);

  @override
  _LearnFromMistakesState createState() => _LearnFromMistakesState();
}

class _LearnFromMistakesState extends State<LearnFromMistakes> {
  final _formKey = GlobalKey<FormState>();
  String _mistake = '';
  String _strategy = '';

  int index = 0;
  int streak = 0;
  bool first = true;

  @override
  Widget build(BuildContext context) {

    print(' ');
    print('in mistakes');

    final model = Provider.of<AlreadyAskedModel>(context, listen: false);

    return StreamBuilder(
      stream: QuestionDatabaseService().questionStreamByCategory(widget.mistakeCategory),
      builder: (buildContext, snapshot) {
          if (snapshot.data != null) {
            // find what the first question should be
            // remember that index no longer is the same as id because there is a category filter
            if (first) {
              for (int i = 0; i < snapshot.data.documents.length; i++) {
              if (model.hasAsked(QuestionDatabaseService()
                  .questionFromSnapshot(snapshot.data.documents[i])
                  .docId)) {
                print(QuestionDatabaseService()
                    .questionFromSnapshot(snapshot.data.documents[i])
                    .docId);
                continue;
              } else {
                index = i;
                first = false;
                break;
              }
              index = 0;
              print('question DNE');
            }
              first = false;
            print('starting index for the category $index');
          }


          return Scaffold(
          appBar: AppBar(
            title: Text('Do more questions about ${widget.mistakeCategory}'),
            actions: <Widget> [
              FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      AuthService().signOut();
                    });
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign Out'))
            ]
          ),

          /* strategies they have from the question screen
             michael's reccomended strategy
             stats about the question
             more questions about it
          */
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget> [
                Form(
                  key: _formKey,
                  child: Row(
                    children: <Widget> [
                      Expanded(
                        child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: textInputDecoration.copyWith(hintText:
                            'Why did you get this specific problem wrong?'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onChanged: (value) {
                              setState(() => _mistake = value);
                          },
                        )
                      ),
                      Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: textInputDecoration.copyWith(hintText:
                                'What will you do next time?'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() => _strategy = value);
                              },
                          )
                      ),
                      RaisedButton.icon(
                          onPressed: () {
                            UserDatabaseService(uid: widget.uid).addStrategy(
                              widget.mistakeCategory, widget.missedQuestion.dbPath,
                              _mistake, _strategy);
                          },
                          icon: Icon(Icons.send),
                          label: Text('Save strategy')
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                MultipleChoiceWidget(
                    mc: QuestionDatabaseService().questionFromSnapshot
                      (snapshot.data.documents[index]),
                    next: ({String mistakeCategory}) async {
                      if(mistakeCategory != null)
                        setState(() => streak = 0);
                      else
                        setState(() => streak += 1);

                      if (index + 1 == snapshot.data.documents.length) {
                        print('out of questions');
                        Navigator.pop(buildContext);
                        Navigator.pop(context);
                      }

                      if (index < snapshot.data.documents.length) {
                        int remainingQuestions = snapshot.data.documents.length - index;
                        for (int i = 0; i < remainingQuestions; i++) {
                          if(!model.hasAsked(QuestionDatabaseService().questionFromSnapshot
                            (snapshot.data.documents[index + i]).docId)) {
                            setState(() { index = index + i; print('next category index $index');});
                            break;
                          }
                        }
                      }


                      /* int add = 0;
                      for(int x in model.alreadyAsked) {
                        if(QuestionDatabaseService().questionFromSnapshot
                          (snapshot.data.documents[index]).docId == x) {
                          add = 2;
                        } else add = 1;
                      }

                      if ((index + add) < snapshot.data.documents.length - 1)
                        setState(() => index += add);
                      else {
                        print(context.toString());
                        print('out of questions');
                        Navigator.pop(buildContext);
                        Navigator.pop(context);
                      } */
                    }
                  ),
                Row(
                  children: <Widget> [
                    Text('Streak '),
                    Text(streak.toString())
                  ]
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )
        );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('testing'),
            ),
          );
        }
      }
    );
  }

  Future<void> _noMoreQuestions() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No More Questions'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You ran out of questions.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Go back to home'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}


