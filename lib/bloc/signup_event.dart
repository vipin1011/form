part of 'signup_bloc.dart';

class SignupEvent {}

class ToggleGender extends SignupEvent {
  final String gender;

  ToggleGender({required this.gender});
}

class ToggleNotifications extends SignupEvent {
  final bool receiveNotifications;

  ToggleNotifications({required this.receiveNotifications});
}

class TogglePolicy extends SignupEvent {
  final bool acceptPolicy;

  TogglePolicy({required this.acceptPolicy});
}

class ClearState extends SignupEvent {

}

class FormSubmitted extends SignupEvent {
  final String firstName;
  final String lastName;

  FormSubmitted({required this.firstName, required this.lastName});
}