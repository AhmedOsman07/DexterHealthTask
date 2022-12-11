import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nursing_home_dexter/data/entity/nurses_model.dart';

import '../../shared/utils/user_singelton.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignupCredentialsEvent>(_signUp);
  }

  FutureOr<void> _signUp(SignupCredentialsEvent event, Emitter<SignUpState> emit) async {
    emit(SignupLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: event.email, password: event.password)
        .then((user) async {
      final userObject = <String, Object>{
        "name": event.name,
        "pendingTasks": 0,
        "completedTasks": 0
      };
      log(user.user!.uid);
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.user?.uid)
          .set(userObject)
          .onError((e, _) => print("Error writing document: $e"))
          .then((value) {
        AppSingleton.getInstance.setUser(user.user,NurseModel(name: event.name, completedTasks: 0, pendingTasks: 0));
        emit(SignupSuccessfulState("Signed up successfully"));
      });
    }).onError((error, stackTrace) async {
      final e = error as FirebaseAuthException;
      if (e.code == 'email-already-in-use') {
        emit(SignupErrorState("Account already exists with the given email address"));
      } else if (e.code == 'user-not-found') {
        emit(SignupErrorState("No user found for that email."));
      } else if (e.code == 'weak-password') {
        emit(SignupErrorState("Password is not strong enough."));
      } else if (e.code == 'invalid-email') {
        emit(SignupErrorState("Invalid credentials."));
      } else {
        emit(SignupErrorState(e.message ?? "Failed to log in"));
      }
    });
  }
}
