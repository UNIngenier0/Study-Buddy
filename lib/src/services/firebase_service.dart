import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  FirebaseService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  User? get user => _user;

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
    } else {
      _user = firebaseUser;
    }
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(User? user) async {
    try {
      await user!.delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
