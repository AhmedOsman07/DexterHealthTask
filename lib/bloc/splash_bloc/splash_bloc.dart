import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:nursing_home_dexter/data/FirebaseRepo.dart';

import '../../shared/utils/user_singelton.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<AppStartEvent>(_validateAuthState);
  }

  FutureOr<void> _validateAuthState(AppStartEvent event, Emitter<SplashState> emit) async {
    await FirebaseAuth.instance.authStateChanges().every((User? user) {
      if (user == null) {
        emit(SplashUnAuthenticatedState());
      } else {
        getUserData(user, emit);
      }
      return user != null;
    });
  }

  void getUserData(User user, Emitter<SplashState> emit) async {
    await FirebaseRepo().nursesRef.doc(user.uid).get().then((value) async {
      emit(SplashAuthenticatedState());
      AppSingleton.getInstance.setUser(user, value.data()!);
    });
  }
}
