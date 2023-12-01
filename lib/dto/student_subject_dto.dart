class StudentSubjectDto {
  int enrollmentId;
  int teacherUserId;
  String teacherFirstName;
  String teacherLastName;
  int subjectId;
  String subjectName;
  String semester;
  String year; // FIXME: cambiar a int
  String parallel; // FIXME: cambiar a int
  bool evaluated;

  StudentSubjectDto(
      {required this.enrollmentId,
      required this.teacherUserId,
      required this.teacherFirstName,
      required this.teacherLastName,
      required this.subjectId,
      required this.subjectName,
      required this.semester,
      required this.year,
      required this.parallel,
      required this.evaluated});

  factory StudentSubjectDto.fromJson(Map<String, dynamic> json) {
    return StudentSubjectDto(
        enrollmentId: json['enrollmentId'],
        teacherUserId: json['teacherUserId'],
        teacherFirstName: json['teacherFirstName'],
        teacherLastName: json['teacherLastName'],
        subjectId: json['subjectId'],
        subjectName: json['subjectName'],
        semester: json['semester'],
        year: json['year'],
        parallel: json['parallel'],
        evaluated: json['evaluated']);
  }

  Map<String, dynamic> toJson() => {
        'enrollmentId': enrollmentId,
        'teacherUserId': teacherUserId,
        'teacherFirstName': teacherFirstName,
        'teacherLastName': teacherLastName,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'semester': semester,
        'year': year,
        'parallel': parallel,
        'evaluated': evaluated
      };
}
