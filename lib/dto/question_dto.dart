class QuestionDto {
  int questionId;
  String questionText;

  QuestionDto({required this.questionId, required this.questionText});

  factory QuestionDto.fromJson(Map<String, dynamic> json) {
    return QuestionDto(
        questionId: json['questionId'], questionText: json['questionText']);
  }

  Map<String, dynamic> toJson() =>
      {'questionId': questionId, 'questionText': questionText};
}
