import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

//analyser les donnees du json

 Users userFromJson(String str) {
  final jsonData = json.decode(str);
  return Users.fromJson(jsonData);
}
  String userToJson (Users data) {
    final dyn = data.toJson();
    return json.encode(dyn);
  }

 class Users {
    String id;
    String first_name;
    String last_name;
    String email;

    Users({
      this.id,
      this.first_name,
      this.last_name,
      this.email,
 });
    factory Users.fromJson(Map<String, dynamic> json) => new Users(
      id : json["id"],
      first_name : json["first_name"],
      last_name : json["last_name"],
      email : json[" email"],
    );
    Map<String, dynamic> toJson () => {
      "id" : id,
      "first_name" : first_name,
      "last_name" : last_name,
      "email" : email,
    };
    factory Users.fromDocument(DocumentSnapshot doc) {
      return Users.fromJson(doc.data);
    }
 }