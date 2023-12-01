class TeacherSubjectDto {
  int teacherSubjectId;
  int subjectId;
  String subjectName;
  String parallel;
  String evaluationPercent;

  TeacherSubjectDto(
      {required this.teacherSubjectId,
      required this.subjectId,
      required this.subjectName,
      required this.parallel,
      required this.evaluationPercent});

  factory TeacherSubjectDto.fromJson(Map<String, dynamic> json) {
    return TeacherSubjectDto(
        teacherSubjectId: json['teacherSubjectId'],
        subjectId: json['subjectId'],
        subjectName: json['subjectName'],
        parallel: json['parallel'],
        evaluationPercent: json['evaluationPercent']);
  }

  Map<String, dynamic> toJson() => {
        'teacherSubjectId': teacherSubjectId,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'parallel': parallel,
        'evaluationPercent': evaluationPercent
      };
}
