import 'dart:async';
import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/bloc/teacher_query_state.dart';
import 'package:evaluacion_docente_frontend/service/teacher_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherQueryCubit extends Cubit<TeacherQueryState> {
  TeacherQueryCubit() : super(TeacherQueryState.initial());

  Future<String> makeQuery(int teacherSubjectId, String prompt) async {
    emit(state.copyWith(status: PageStatus.loading));
    String result = '';

    try {
      result = await TeacherService.makeQuery(teacherSubjectId, prompt);
      emit(state.copyWith(
        status: PageStatus.success,
        data: await TeacherService.getSubjectQueries(
          teacherSubjectId, // actualización de lista de consultas // esto es importante
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
          status: PageStatus.failure, errorMessage: e.toString()));
    }
    return result;
  }

  Future<void> getSubjectQueries(int teacherSubjectId) async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final result = await TeacherService.getSubjectQueries(teacherSubjectId);
      emit(state.copyWith(status: PageStatus.success, data: result));
    } catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
