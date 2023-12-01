import 'package:evaluacion_docente_frontend/dto/student_subject_dto.dart';

enum PageStatus { initial, loading, success, failure }

class StudentState {
  final PageStatus status; // inicial, cargando, éxito, falla
  final List<StudentSubjectDto> data;
  final String? errorMessage;

  StudentState({
    required this.status,
    required this.data,
    this.errorMessage,
  });

  factory StudentState.initial() {
    return StudentState(
      status: PageStatus.initial,
      data: [],
    );
  }

  StudentState copyWith({
    PageStatus? status,
    List<StudentSubjectDto>? data,
    String? errorMessage,
  }) {
    return StudentState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
