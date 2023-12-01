import 'package:evaluacion_docente_frontend/bloc/student_state.dart';
import 'package:evaluacion_docente_frontend/service/student_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentState.initial());

  Future<void> getSubjects() async {
    emit(state.copyWith(status: PageStatus.loading));
    try {
      final result = await StudentService.getSubjects();
      emit(state.copyWith(status: PageStatus.success, data: result));
    } catch (e) {
      emit(state.copyWith(
        status: PageStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
