part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignupLoadingState extends SignUpState {
  SignupLoadingState();
}

class SignupErrorState extends SignUpState {
  final String message;

  SignupErrorState(this.message);
}

class SignupSuccessfulState extends SignUpState {
  final String message;

  SignupSuccessfulState(this.message);
}
