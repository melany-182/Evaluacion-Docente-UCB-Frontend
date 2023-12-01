import 'package:auth0_flutter/auth0_flutter.dart';

class UserState {
  final UserProfile? user;
  final bool isAuthenticated;

  UserState({
    this.user,
    this.isAuthenticated = false,
  });

  factory UserState.initial() => UserState();

  UserState copyWith({
    UserProfile? user,
    bool? isAuthenticated,
  }) {
    return UserState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
