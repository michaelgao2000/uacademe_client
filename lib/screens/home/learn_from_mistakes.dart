import 'package:client/question_types/multiple_choice_widget.dart';
import 'package:client/question_types/multiple_choice_template.dart';
import 'package:client/services/question_database.dart';
import 'package:client/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:client/models/user.dart';

class LearnFromMistakes extends StatefulWidget {
  final String mistakeCategory;

  LearnFromMistakes({Key key, this.mistakeCategory}) : super(key:key);

  @override
  _LearnFromMistakesState createState() => _LearnFromMistakesState();
}

class _LearnFromMistakesState extends State<LearnFromMistakes> {
  final _formKey = GlobalKey<FormState>();
  String _mistake = '';
  String _strategy = '';

  int index = 0;
  int streak = 0;



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print('learn from mistakes');
    print(user.toString());

    return StreamBuilder(
      stream: QuestionDatabaseService().questionStreamByCategory(widget.mistakeCategory),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return Scaffold(
          appBar: AppBar(
            title: Text('Do more questions about ${widget.mistakeCategory}')
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
                            return null;
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
                    next: ({String mistakeCategory}) {
                      print(mistakeCategory);
                      if(mistakeCategory != null)
                        setState(() => streak = 0);
                      else
                        setState(() => streak += 1);

                      if ((index + 1) < snapshot.data.documents.length)
                        setState(() => index += 1);
                      else
                        // TODO if we are out of questions, what do we do
                        print('out of questions');
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
}