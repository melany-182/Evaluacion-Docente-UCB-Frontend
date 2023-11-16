import 'package:evaluacion_docente_frontend/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState.initial());

  void setUserTypeId(final int userTypeId) {
    emit(state.copyWith(userTypeId: userTypeId));
  }

  void setName(final String name) {
    emit(state.copyWith(name: name));
  }

  void setEmail(final String email) {
    emit(state.copyWith(email: email));
  }
}
