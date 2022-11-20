import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mokamayu/services/authentication/auth.dart';

class ProfileManager extends ChangeNotifier {
  // TODO(karina): change and implement!
  User get getUser => AuthService().currentUser!;
}