import 'package:evaluacion_docente_frontend/dto/student_subject_dto.dart';

enum PageStatus { initial, loading, success, failure }

class StudentSubjectState {
  final PageStatus status; // inicial, cargando, éxito, falla
  final List<StudentSubjectDto> data;
  final String? errorMessage;

  StudentSubjectState({
    required this.status,
    required this.data,
    this.errorMessage,
  });

  factory StudentSubjectState.initial() {
    return StudentSubjectState(
      status: PageStatus.initial,
      data: [],
    );
  }

  StudentSubjectState copyWith({
    PageStatus? status,
    List<StudentSubjectDto>? data,
    String? errorMessage,
  }) {
    return StudentSubjectState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
