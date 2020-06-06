import 'package:client/question_types/multiple_choice_template.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/home/learn_from_mistakes.dart';
import 'package:flutter/material.dart';
import 'package:client/models/already_asked.dart';

class MultipleChoiceWidget extends StatefulWidget {

  final MultipleChoice mc;
  final Function next;

  MultipleChoiceWidget({Key key, this.mc, this.next}) : super(key:key);

  @override
  _MultipleChoiceWidgetState createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {

  String buttonText = 'Submit';
  int _answerChoice;
  int _correctAnswer;

  void _changeAnswerChoice(int value) {
    setState(() {
      _answerChoice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    AlreadyAskedModel model = AlreadyAskedModel.of(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // question + form
          Text('${widget.mc.question}', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      Text('${widget.mc.answerChoices[0]}'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${widget.mc.answerChoices[1]}'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${widget.mc.answerChoices[2]}'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('${widget.mc.answerChoices[3]}'),
                    ],
                  ),
                ]
            ),
          ),

          // submit
          RaisedButton(
            onPressed: () {
              _correctAnswer = widget.mc.correctAnswer;
              setState(() {
                print('set state');
                model.alreadyAsked.add(widget.mc.docId);
                print('print list');
                for (String x in model.alreadyAsked) {
                  print(x);
                }

                if(_answerChoice == _correctAnswer) {
                  _answerChoice = null;
                  _showResult(true);
                  widget.next();
                } else {
                  _showResult(false);
                  widget.next(mistakeCategory: widget.mc.category);
                }
              });
            },
            child: Text('$buttonText'),
          )
        ]
    );
  }

  Future<void> _showResult(bool result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        if(result == true){
          return AlertDialog(
            title: Text('Result'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You got the question correct.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Next question'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('Result'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You got the question wrong.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Do more questions of the same type'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }
}


