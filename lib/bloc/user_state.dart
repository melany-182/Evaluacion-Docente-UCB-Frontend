class UserState {
  final int userTypeId;
  final String name;
  final String email;

  UserState({
    required this.userTypeId,
    required this.name,
    required this.email,
  });

  factory UserState.initial() {
    return UserState(
      userTypeId: 0,
      name: '',
      email: '',
    );
  }

  UserState copyWith({
    int? userTypeId,
    String? name,
    String? email,
  }) {
    return UserState(
      userTypeId: userTypeId ?? this.userTypeId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
