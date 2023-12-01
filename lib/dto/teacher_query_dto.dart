class TeacherQueryDto {
  int teacherQueryId;
  String queryText;
  String? apiResponse;
  String date; // * FIXME: Date en Java

  TeacherQueryDto({
    required this.teacherQueryId,
    required this.queryText,
    required this.apiResponse,
    required this.date,
  });

  factory TeacherQueryDto.fromJson(Map<String, dynamic> json) {
    return TeacherQueryDto(
      teacherQueryId: json['teacherQueryId'],
      queryText: json['queryText'],
      apiResponse: json['apiResponse'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherQueryId': teacherQueryId,
      'queryText': queryText,
      'apiResponse': apiResponse,
      'date': date,
    };
  }
}
