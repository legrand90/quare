import 'package:firebase_auth/firebase_auth.dart';
import 'settings.dart';
import 'users.dart';

class StateModel {
  bool isLoading;
  FirebaseUser firebaseUserAuth;
  Users users;
  Settings settings;

  StateModel({
    this.isLoading,
    this.firebaseUserAuth,
    this.users,
    this.settings
});
}