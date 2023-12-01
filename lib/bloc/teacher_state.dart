import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/dto/teacher_subject_dto.dart';

class TeacherState {
  final PageStatus status; // inicial, cargando, éxito, falla
  final List<TeacherSubjectDto> data;
  final String? errorMessage;

  TeacherState({
    required this.status,
    required this.data,
    this.errorMessage,
  });

  factory TeacherState.initial() {
    return TeacherState(
      status: PageStatus.initial,
      data: [],
    );
  }

  TeacherState copyWith({
    PageStatus? status,
    List<TeacherSubjectDto>? data,
    String? errorMessage,
  }) {
    return TeacherState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
