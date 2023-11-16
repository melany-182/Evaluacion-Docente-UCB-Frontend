import 'package:evaluacion_docente_frontend/bloc/student_subject_state.dart';
import 'package:evaluacion_docente_frontend/service/student_subject_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentSubjectCubit extends Cubit<StudentSubjectState> {
  StudentSubjectCubit() : super(StudentSubjectState.initial());

  Future<void> getSubjects() async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final result = await StudentSubjectService.getSubjects();
      emit(state.copyWith(status: PageStatus.success, data: result));
    } catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
