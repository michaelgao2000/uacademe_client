import 'package:client/question_types/multiple_choice_template.dart';
import 'package:flutter/material.dart';

class MultipleChoiceWidget extends StatefulWidget {

  final MultipleChoice mc;
  MultipleChoiceWidget({Key key, this.mc}) : super(key:key);

  @override
  _MultipleChoiceWidgetState createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  MultipleChoice mc;
  _MultipleChoiceWidgetState({this.mc});

  String buttonText = 'Submit';
  int _answerChoice;

  void _changeAnswerChoice(int value) {
    setState(() {
      _answerChoice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // question + form
          Text('${mc.question}', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${mc.answerChoices[0]}'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${mc.answerChoices[0]}'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${mc.answerChoices[0]}'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${mc.answerChoices[0]}'),
                    ],
                  ),
                ]
            ),
          ),

          // submit
          RaisedButton(
            onPressed: () {
              setState(() {
                if(_answerChoice == mc.correctAnswer) {
                  buttonText = 'This is correct.';
                } else {
                  buttonText = 'This is wrong.';
                }
              });
            },
            child: Text('$buttonText'),
          )
        ]
    );
  }
}
