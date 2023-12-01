import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/dto/question_dto.dart';

class QuestionState {
  final PageStatus status; // inicial, cargando, éxito, falla
  final List<QuestionDto> data;
  final String? errorMessage;

  QuestionState({
    required this.status,
    required this.data,
    this.errorMessage,
  });

  factory QuestionState.initial() {
    return QuestionState(
      status: PageStatus.initial,
      data: [],
    );
  }

  QuestionState copyWith({
    PageStatus? status,
    List<QuestionDto>? data,
    String? errorMessage,
  }) {
    return QuestionState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
