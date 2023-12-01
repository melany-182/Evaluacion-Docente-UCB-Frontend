import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:evaluacion_docente_frontend/bloc/user_state.dart';
import 'package:evaluacion_docente_frontend/secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final SecureStorage secureStorage;

  UserCubit(this.secureStorage) : super(UserState());

  Future<void> login(Auth0 auth0, String scheme) async {
    try {
      var credentials = await auth0.webAuthentication(scheme: scheme).login();
      await secureStorage.persistToken(credentials.accessToken);
      emit(UserState(user: credentials.user, isAuthenticated: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(Auth0 auth0, String scheme) async {
    try {
      await auth0.webAuthentication(scheme: scheme).logout();
      await secureStorage.deleteToken();
      emit(UserState());
    } catch (e) {
      print(e);
    }
  }
}
