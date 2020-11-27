import 'dart:async';
import '../services/auth_api.dart';
class AuthenticationBloc{
  final Authapi authapi;


  final StreamController<String> _authController = StreamController<String>();
  Sink<String> get addUser => _authController.sink;
  Stream<String> get user =>_authController.stream;
  final StreamController<bool> _logoutController = StreamController<bool>();
  Sink<bool> get logoutUser => _logoutController.sink;
  Stream<bool> get listLogoutUser => _logoutController.stream;
  AuthenticationBloc(this.authapi){
  onAuthChanged();
}
  void dispose(){
    _authController.close();
    _logoutController.close();
  }

  void onAuthChanged() {
    authapi.getFirebaseAuth().onAuthChanged.listen((user) {
      final String uid = user != null ? user.uid : null;
      addUser.add(uid);
    });
    _logoutController.stream.listen((logout) {
      if(logout == true){
        _signOut();
      }
    });
  }
  void _signOut(){
    authapi.SignOut();
  }
}

