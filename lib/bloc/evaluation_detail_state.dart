import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/dto/evaluation_detail_dto.dart';

class EvaluationDetailState {
  final PageStatus status; // inicial, cargando, éxito, falla
  final List<EvaluationDetailDto> data;
  final String? errorMessage;

  EvaluationDetailState({
    required this.status,
    required this.data,
    this.errorMessage,
  });

  factory EvaluationDetailState.initial() {
    return EvaluationDetailState(
      status: PageStatus.initial,
      data: [],
    );
  }

  EvaluationDetailState copyWith({
    PageStatus? status,
    List<EvaluationDetailDto>? data,
    String? errorMessage,
  }) {
    return EvaluationDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
