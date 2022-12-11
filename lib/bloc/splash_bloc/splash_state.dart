part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashAuthenticatedState extends SplashState {}

class SplashUnAuthenticatedState extends SplashState {}
