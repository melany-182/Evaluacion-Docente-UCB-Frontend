import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/dto/teacher_query_dto.dart';

class TeacherQueryState {
  final PageStatus status; // inicial, cargando, éxito, falla
  final List<TeacherQueryDto> data;
  final String? errorMessage;

  TeacherQueryState({
    required this.status,
    required this.data,
    this.errorMessage,
  });

  factory TeacherQueryState.initial() {
    return TeacherQueryState(
      status: PageStatus.initial,
      data: [],
    );
  }

  TeacherQueryState copyWith({
    PageStatus? status,
    List<TeacherQueryDto>? data,
    String? errorMessage,
  }) {
    return TeacherQueryState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
