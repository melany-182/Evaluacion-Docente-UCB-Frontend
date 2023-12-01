import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/bloc/teacher_state.dart';
import 'package:evaluacion_docente_frontend/service/teacher_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherCubit extends Cubit<TeacherState> {
  TeacherCubit() : super(TeacherState.initial());

  Future<void> getSubjects() async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final result = await TeacherService.getSubjects();
      emit(state.copyWith(status: PageStatus.success, data: result));
    } catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
