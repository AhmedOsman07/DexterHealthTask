part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignupCredentialsEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;

  SignupCredentialsEvent({required this.name, required this.email, required this.password});
}
