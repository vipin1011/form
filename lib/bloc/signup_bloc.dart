import 'package:bloc/bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()){
    on<ToggleNotifications>((event, emit) {
      emit(state.copyWith(receiveNotifications: event.receiveNotifications));
    });
    on<TogglePolicy>((event, emit) {
      emit(state.copyWith(acceptPolicy: event.acceptPolicy));
    });
    on<ToggleGender>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });
    on<ClearState>((event, emit) {
      emit(state.copyWith(gender: 'male', acceptPolicy: false, errorMessage: '',receiveNotifications: false,username: ''));
    });
    on<FormSubmitted>((event, emit) {
      bool isValid = _validateForm(event.firstName, event.lastName);
      if (isValid) {
        emit(state.copyWith(username: '${event.firstName} ${event.lastName}', errorMessage: ''));
      }else {
        emit(state.copyWith(errorMessage: 'Please fill all required fields.'));
      }
    });
  }


  bool _validateForm(String firstName, String lastName) {
    return firstName.isNotEmpty && lastName.isNotEmpty;
  }
}
