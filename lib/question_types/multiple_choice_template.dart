import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';


class MultipleChoice {
  int difficulty;
  String category;
  int section;

  String question;
  List<String> answerChoices;
  int correctAnswer;

  DocumentReference dbPath;
  String docId;

  MultipleChoice({this.question, this.answerChoices, this.correctAnswer,
    this.difficulty, this.category, this.section, this.dbPath, this.docId});


}