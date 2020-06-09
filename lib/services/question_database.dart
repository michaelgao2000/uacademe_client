
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:client/question_types/multiple_choice_template.dart';

// TODO no duplicates

class QuestionDatabaseService {
  final CollectionReference questionCollection = Firestore.instance.
    collection("questions");

  MultipleChoice questionFromSnapshot(DocumentSnapshot question) {
    return new MultipleChoice(
      question: question.data['question'],
      answerChoices: [question.data['answera'], question.data['answerb'],
        question.data['answerc'], question.data['answerd']],
      correctAnswer: question.data['correct answer'],
      difficulty: question.data['difficulty'],
      category: question.data['category'],
      section: question.data['section'],
      dbPath: question.reference,
      docId: question.data['id']
    );
  }

  Stream<QuerySnapshot> get questionStream {
    return questionCollection.snapshots();
  }

  Stream<QuerySnapshot> questionStreamByCategory(String cat) {
    return questionCollection.where("category", isEqualTo: cat).snapshots();
  }


  // not being used
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

  Stream<List<MultipleChoice>> get questions {
    return questionCollection.snapshots().map(_questionListFromSnapshot);
  }


}