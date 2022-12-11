import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/FirebaseRepo.dart';
import '../../shared/utils/user_singelton.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginCredentialsEvent>(_signIn);
  }

  getUserData(User user, Emitter<LoginState> emit) async {
    await FirebaseRepo().nursesRef.doc(user.uid).get().then((value) async {
      emit(LoginSuccessfulState());
      AppSingleton.getInstance.setUser(user, value.data()!);
    });
  }

  FutureOr<void> _signIn(LoginCredentialsEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: event.email, password: event.password)
        .then((user) async {
      await getUserData(user.user!, emit);
    }).onError((error, stackTrace) async {
      final e = error as FirebaseAuthException;
      if (e.code == 'invalid-email') {
        emit(LoginErrorState("Invalid credentials"));
      } else if (e.code == 'user-not-found') {
        emit(LoginErrorState("No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState("Invalid credentials"));
      } else if (e.code == 'user-disabled') {
        emit(LoginErrorState('User was disabled. Please contact system administrator.'));
      } else {
        emit(LoginErrorState(e.message ?? "Failed to log in"));
      }
    });
  }
}
