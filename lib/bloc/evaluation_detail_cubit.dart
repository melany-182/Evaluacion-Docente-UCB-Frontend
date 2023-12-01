import 'package:evaluacion_docente_frontend/bloc/evaluation_detail_state.dart';
import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/service/teacher_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EvaluationDetailCubit extends Cubit<EvaluationDetailState> {
  EvaluationDetailCubit() : super(EvaluationDetailState.initial());

  Future<void> generateSubjectEvaluationDetail(int teacherSubjectId) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      await TeacherService.generateSubjectEvaluationDetail(teacherSubjectId);
      emit(state.copyWith(status: PageStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: PageStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> getSubjectEvaluationDetails(int teacherSubjectId) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      var evaluationDetail =
          await TeacherService.getSubjectEvaluationDetails(teacherSubjectId);
      emit(state.copyWith(status: PageStatus.success, data: evaluationDetail));
    } catch (e) {
      emit(state.copyWith(
          status: PageStatus.failure, errorMessage: e.toString()));
    }
  }
}
