import 'package:firebase_auth/firebase_auth.dart';
import 'package:nursing_home_dexter/data/entity/nurses_model.dart';

class AppSingleton {
  static AppSingleton? _instance;

  AppSingleton._();

  static AppSingleton get getInstance => _instance ??= AppSingleton._();
  User? user;
  NurseModel? data;

  void setUser(User? user, NurseModel data) {
    this.user = user;
    this.data = data;
  }

  User? getUser() {
    return user;
  }

  NurseModel? getNurseModel() {
    return data;
  }
}
