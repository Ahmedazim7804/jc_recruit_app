import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final _getIt = GetIt.instance;

  String? name;
  String? email;
  String? studentId;

  void getFromSharedPrefs() {
    name = _getIt<SharedPreferences>().getString('name');
    email = _getIt<SharedPreferences>().getString('email');
    studentId = _getIt<SharedPreferences>().getString('studentId');
  }

  Future<bool> checkIfLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      getFromSharedPrefs();
      return true;
    }

    return false;
  }

  void setDetails(String name, String email, String studentId) async {
    this.name = name;
    this.email = email;
    this.studentId = studentId;

    await _getIt<SharedPreferences>().setString('name', name);
    await _getIt<SharedPreferences>().setString('email', email);
    await _getIt<SharedPreferences>().setString('studentId', studentId);
  }

  void _clearDetails() {
    name = null;
    email = null;
    studentId = null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _clearDetails();
  }
}
