import 'package:flutter/material.dart';
import 'package:client/question_types/multiple_choice_template.dart';
import 'package:client/question_types/multiple_choice_widget.dart';

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
  MultipleChoice mc = new MultipleChoice(difficulty: 3,
      category: "Algebra", question: "5 = x + 3", answerChoices:
      ["2", "3", "-2", "-3"], correctAnswer: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uAcadeMe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MultipleChoiceWidget(
          mc: mc,
        )
        ),
      );
  }
}

