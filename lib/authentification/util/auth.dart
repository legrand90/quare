import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/users.dart';
import '../Models/settings.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
  static Future<String> signUp(String email, String password) async {
    FirebaseUser users = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return users.uid;
  }
//ajouter un utilisateur
  static void addUserSettingsDB(Users users) async {
    checkUserExist(users.id).then((value) {
      if (!value) {
        print("utilisateur ${users.first_name} ${users.email} ajouter");
        Firestore.instance
            .document("users/${users.id}")
            .setData(users.toJson());
        _addSettings(new Settings(
          settingsId: users.id,
        ));
      } else {
        print("utilisateur ${users.first_name} ${users.email} existe");
      }
    });
  }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userId").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static void _addSettings(Settings settings) async {
    Firestore.instance
        .document("parametres/${settings.settingsId}")
        .setData(settings.toJson());
  }

  static Future<String> signIn(String email, String password) async {
    FirebaseUser users= await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return users.uid;
  }

  static Future<Users> getUserFirestore(String userId) async {
    if (userId != null) {
      return Firestore.instance
          .collection('users')
          .document(userId)
          .get()
          .then((documentSnapshot) => Users.fromDocument(documentSnapshot));
    } else {
      print("l'identifiant de l'utilisateur ne peut pas etre vide");
      return null;
    }
  }

  static Future<Settings> getSettingsFirestore(String settingsId) async {
    if (settingsId != null) {
      return Firestore.instance
          .collection('settings')
          .document(settingsId)
          .get()
          .then((documentSnapshot) => Settings.fromDocument(documentSnapshot));
    } else {
      print('les parametres de firestore sont pas disponible');
      return null;
    }
  }

  static Future<String> storeUserLocal(Users users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(users);
    await prefs.setString('users', storeUser);
    return users.id;
  }

  static Future<String> storeSettingsLocal(Settings settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeSettings = settingsToJson(settings);
    await prefs.setString('settings', storeSettings);
    return settings.settingsId;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser;
  }

  static Future<Users> getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Users user = userFromJson(prefs.getString('user'));
      //print('USER: $user');
      return user;
    } else {
      return null;
    }
  }

  static Future<Settings> getSettingsLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('settings') != null) {
      Settings settings = settingsFromJson(prefs.getString('settings'));
      //print('SETTINGS: $settings');
      return settings;
    } else {
      return null;
    }
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    FirebaseAuth.instance.signOut();
  }

  static Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case "Il n'a pas d'utlisateur qui a ce identifiant. L'utilisateur peut etre supprime.":
          return 'Utilisateur avec ce mail existe deja.';
          break;
        case "Le mot de passe est invalide ou il n'a pas de mot de passe.":
          return 'Mot de passe invalide.';
          break;
        case 'Erreur reseau (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'Pas de connection internet.';
          break;
        case 'Le mail existe deja et est utilise pour un autre utilisateur.':
          return 'Ce mail existe et a deja un compte.';
          break;
        default:
          return 'Erreur inconnu.';
      }
    } else {
      return 'Erreur inconnu.';
    }
  }
}