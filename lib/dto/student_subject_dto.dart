class StudentSubjectDto {
  int enrollmentId;
  int subjectEvaluationId;
  String teacherFirstName;
  String teacherLastName;
  int subjectId;
  String subjectName;
  String semester;
  String year;
  String parallel;
  bool evaluated;

  StudentSubjectDto({
    required this.enrollmentId,
    required this.subjectEvaluationId,
    required this.teacherFirstName,
    required this.teacherLastName,
    required this.subjectId,
    required this.subjectName,
    required this.semester,
    required this.year,
    required this.parallel,
    required this.evaluated,
  });

  factory StudentSubjectDto.fromJson(Map<String, dynamic> json) {
    return StudentSubjectDto(
      enrollmentId: json['enrollmentId'] as int,
      subjectEvaluationId: json['subjectEvaluationId'] as int,
      teacherFirstName: json['teacherFirstName'] as String,
      teacherLastName: json['teacherLastName'] as String,
      subjectId: json['subjectId'] as int,
      subjectName: json['subjectName'] as String,
      semester: json['semester'] as String,
      year: json['year'] as String,
      parallel: json['parallel'] as String,
      evaluated: json['evaluated'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enrollmentId': enrollmentId,
      'subjectEvaluationId': subjectEvaluationId,
      'teacherFirstName': teacherFirstName,
      'teacherLastName': teacherLastName,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'semester': semester,
      'year': year,
      'parallel': parallel,
      'evaluated': evaluated,
    };
  }
}
