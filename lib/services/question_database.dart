import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client/question_types/multiple_choice_template.dart';

class QuestionDatabaseService {
  final CollectionReference questionCollection = Firestore.instance.
    collection("questions");

  List<MultipleChoice> _questionListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((question) {
      return MultipleChoice(
        question: question.data['question'],
        answerChoices: [question.data['answera'], question.data['answerb'],
          question.data['answerc'], question.data['answerd']],
        correctAnswer: question.data['correct answer'],
        difficulty: question.data['difficulty'],
        category: question.data['category'],
        section: question.data['section']
      );
    }).toList();
  }

  MultipleChoice questionFromSnapshot(DocumentSnapshot question) {
    return MultipleChoice(
        question: question.data['question'],
        answerChoices: [question.data['answera'], question.data['answerb'],
          question.data['answerc'], question.data['answerd']],
        correctAnswer: question.data['correct answer'],
        difficulty: question.data['difficulty'],
        category: question.data['category'],
        section: question.data['section']
    );
  }

  Stream<List<MultipleChoice>> get questions {
    return questionCollection.snapshots().map(_questionListFromSnapshot);
  }

  Stream<QuerySnapshot> get questionStream {
    return questionCollection.snapshots();
  }
}