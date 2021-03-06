import 'package:firebase_auth/firebase_auth.dart';

abstract class Authapi{
  getFirebaseAuth();
  Future<String> CurrentUserId();
  Future<void> SignOut();
  Future<String> SignInWithEmailPassword({String email, String password});
  Future<String> CreateUserWithEmailPassword({String password, String email});
  Future<void> SendEmailVerification();
  Future<bool> IsEmailVerified();
  //Future<UserCredential> SignInWithGoogle();
}


