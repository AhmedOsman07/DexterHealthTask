part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginCredentialsEvent extends LoginEvent {
  final String email;
  final String password;

  LoginCredentialsEvent({required this.email, required this.password});
}
