import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_api.dart';
class AuthService implements Authapi{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth getFirebaseAuth(){
    return _firebaseAuth;
  }
  Future<String> CurrentUserId() async{
    User user = await _firebaseAuth.currentUser;
    return user.uid;
  }
  Future<String> CreateUserWithEmailPassword({String email,String password}) async {
    User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)) as User;
    return user.uid;
  }
  Future<String> SignInWithEmailPassword({String email,String password}) async {
    User user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)) as User;
    return user.uid;
  }
  Future<void> SendEmailVerification() async {
    User user = await _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }
  Future<bool> IsEmailVerified() async{
    User user = await _firebaseAuth.currentUser;
    return user.emailVerified;
  }
  Future<void> SignOut() async{
    return _firebaseAuth.signOut();
  }

  // Future<String> SignInWithGoogle() async {
  //
  //   final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //
  //
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
  //   User user =  authResult.user;
  //
  //   return user.uid;
  // }
}
