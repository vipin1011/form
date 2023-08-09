part of 'signup_bloc.dart';


class SignupState {
  final String username;
  final String errorMessage;
  final String gender;
  final bool receiveNotifications;
  final bool acceptPolicy;

  SignupState({
    this.username = '',
    this.errorMessage = '',
    this.gender = 'male',
    this.receiveNotifications = false,
    this.acceptPolicy = false,
  });

  SignupState copyWith({
    String? username,
    String? errorMessage,
    String? gender,
    bool? receiveNotifications,
    bool? acceptPolicy,
  }) {
    return SignupState(
      username: username ?? this.username,
      errorMessage: errorMessage ?? this.errorMessage,
      gender: gender ?? this.gender,
      receiveNotifications: receiveNotifications ?? this.receiveNotifications,
      acceptPolicy: acceptPolicy ?? this.acceptPolicy,
    );
  }
}

