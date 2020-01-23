class Question {
  int id;
  String question;
  String correctAnswer;
  String wrongAnswer1;
  String wrongAnswer2;
  String wrongAnswer3;
  int difficulty;
  String category;
  String uploader;
  String source;

  Question({
    this.id,
    this.question,
    this.correctAnswer,
    this.wrongAnswer1,
    this.wrongAnswer2,
    this.wrongAnswer3,
    this.difficulty,
    this.uploader,
    this.source,
    this.category,
  });

  Question.fromMapObject(
      Map<String, dynamic> questionMap, Map<String, dynamic> sharedMap) {
    this.id = questionMap["_id"];
    this.question = questionMap["question"];
    this.correctAnswer = questionMap["correct"];
    this.wrongAnswer1 = questionMap["wrong1"];
    this.wrongAnswer2 = questionMap["wrong2"];
    this.wrongAnswer3 = questionMap["wrong3"];
    this.difficulty = sharedMap["difficulty"];
    this.uploader = sharedMap["uploader"];
    this.source = sharedMap["source"];
    this.category = sharedMap["category"];
  }
}
