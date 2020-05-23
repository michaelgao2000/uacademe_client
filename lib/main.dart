import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String buttonText = 'Submit';

  int _answerChoice;
  int _correctAnswer = 1;

  void _changeAnswerChoice(int value) {
    setState(() {
      _answerChoice = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uAcadeMe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Question', style: TextStyle(fontWeight: FontWeight.bold)),
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
                      Text('Answer Choice A'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('Answer Choice B'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('Answer Choice C'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 4,
                        groupValue: _answerChoice,
                        onChanged: _changeAnswerChoice,
                      ),
                      Text('Answer Choice D'),
                    ],
                  ),
                ]
              ),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  if(_answerChoice == _correctAnswer) {
                    buttonText = 'This is correct.';
                  } else {
                    buttonText = 'This is wrong.';
                  }
                });
              },
              child: Text('$buttonText'),
            )
          ]
        ),
      )
    );
  }
}

