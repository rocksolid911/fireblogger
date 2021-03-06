import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import '../classes/validators.dart';
import '../services/auth_api.dart';

class LoginBloc with Validator {
  final Authapi authapi;
  String _email;
  String _password;
  bool _emailValid;
  bool _passwordValid;

  final StreamController<String> _emailController =
      StreamController<String>.broadcast();
  Sink<String> get emailChanged => _emailController.sink;
  Stream<String> get email => _emailController.stream;

  final StreamController<String> _passwordController =
      StreamController<String>.broadcast();
  Sink<String> get passwordChanged => _passwordController.sink;
  Stream<String> get password => _passwordController.stream;

  final StreamController<bool> _enableLoginCreateButtonController =
      StreamController<bool>.broadcast();
  Sink<bool> get enableLoginCreateButtonChanged =>
      _enableLoginCreateButtonController.sink;
  Stream<bool> get enableLoginCreateButton =>
      _enableLoginCreateButtonController.stream;

  final StreamController<String> _loginOrCreateButtonController =
      StreamController<String>.broadcast();
  Sink<String> get loginOrCreateButtonChanged =>
      _loginOrCreateButtonController.sink;
  Stream<String> get loginOrCreateButton =>
      _loginOrCreateButtonController.stream;

  final StreamController<String> _loginOrCreateController =
      StreamController<String>.broadcast();
  Sink<String> get loginOrCreateChanged => _loginOrCreateController.sink;
  Stream<String> get loginOrCreate => _loginOrCreateController.stream;

  final StreamController<String> _googleLoginController =
  StreamController<String>.broadcast();
  Sink<String> get googleLoginCreateChanged => _googleLoginController.sink;
  Stream<String> get googleLoginOrCreate => _googleLoginController.stream;


  LoginBloc(this.authapi) {
    _startListenersIfEmailPasswordValid();
    _googleLoginEnable();
  }
  void dispose() {
    _passwordController.close();
    _emailController.close();
    _loginOrCreateController.close();
    _enableLoginCreateButtonController.close();
    _loginOrCreateButtonController.close();
    _googleLoginController.close();
  }

  void _startListenersIfEmailPasswordValid() {
    email.listen((email) {
      _email = email;
      _emailValid = true;
      _updateEnableLoginCreateButtonStream();
    }).onError((error) {
      _email = '';
      _emailValid = false;
      _updateEnableLoginCreateButtonStream();
    });
    password.listen((password) {
      _password = password;
      _passwordValid = true;
      _updateEnableLoginCreateButtonStream();
    }).onError((error) {
      _password = '';
      _passwordValid = false;
      _updateEnableLoginCreateButtonStream();
    });

    loginOrCreate.listen(
      (action) {
        // action == 'Login' ? _login() : _createAcount();
        switch (action) {
          case 'Login':
            {
              _login();
            }
            break;
          case 'Create Account':
            {
              _createAcount();
            }
            break;
          // case 'GoogleLogin':
          //   {
          //     _googleLogin();
          //   }
          //   break;
          default:{
            _login();
          }break;
        }
      },
    );
  }

  void _updateEnableLoginCreateButtonStream() {
    if (_emailValid == true && _passwordValid == true) {
      enableLoginCreateButtonChanged.add(true);
    } else {
      enableLoginCreateButtonChanged.add(false);
    }
  }

  Future<String> _login() async {
    String _result = '';
    if (_emailValid == true && _passwordValid == true) {
      await authapi.SignInWithEmailPassword(email: _email, password: _password)
          .then((user) => _result = 'success')
          .catchError((error) {
        print('login error :$error');
        _result = error;
      });
      return _result;
    } else {
      return 'email and password not valid';
    }
  }

  Future<String> _createAcount() async {
    String _result = '';
    if (_emailValid == true && _passwordValid == true) {
      await authapi.CreateUserWithEmailPassword(
              email: _email, password: _password)
          .then((user) {
        print('created user:$user');
        _result = 'created user : $user';
        authapi.SignInWithEmailPassword(email: _email, password: _password)
            .then((user) {})
            .catchError((error) async {
          print('login error:$error');
          _result = error;
        });
      }).catchError((error) async {
        print('creating user error:$error');
      });
      return _result;
    } else {
      return 'error creating user';
    }
  }

  Future<UserCredential> _googleLogin() async {
    enableLoginCreateButtonChanged.add(true);

    //String _result = '';
    if (_emailValid == true && _passwordValid == true) {
    //Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
    };
    }


  void _googleLoginEnable() {
    _GlogIn();
    googleLoginOrCreate.listen((action) {action == 'GoogleLogin'?_googleLogin():_createAcount(); });
  }

  void _GlogIn() {
    googleLoginCreateChanged.add('GoogleLogin');
  }
}
