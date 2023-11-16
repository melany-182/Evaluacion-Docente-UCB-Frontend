class StudentSubjectDto {
  int userSubjectId;
  int teacherUserId;
  String teacherFirstName;
  String teacherLastName;
  int subjectId;
  String subjectName;
  String semester;
  int year;
  int parallel;
  bool evaluated;

  StudentSubjectDto(
      {required this.userSubjectId,
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
        userSubjectId: json['userSubjectId'],
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
        'userSubjectId': userSubjectId,
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
