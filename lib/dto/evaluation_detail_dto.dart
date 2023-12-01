class EvaluationDetailDto {
  String parameter;
  String messageForTeacher;
  double parameterCalification;

  EvaluationDetailDto({
    required this.parameter,
    required this.messageForTeacher,
    required this.parameterCalification,
  });

  factory EvaluationDetailDto.fromJson(Map<String, dynamic> json) {
    return EvaluationDetailDto(
      parameter: json['parameter'],
      messageForTeacher: json['messageForTeacher'],
      parameterCalification: json['parameterCalification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parameter': parameter,
      'messageForTeacher': messageForTeacher,
      'parameterCalification': parameterCalification,
    };
  }
}
