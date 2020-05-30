class MultipleChoice {
  int difficulty;
  String category;
  int section;

  String question;
  List<String> answerChoices;
  int correctAnswer;

  MultipleChoice({this.question, this.answerChoices, this.correctAnswer,
    this.difficulty, this.category, this.section});
}