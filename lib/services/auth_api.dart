abstract class Authapi{
  getFirebaseAuth();
  Future<String> CurrentUserId();
  Future<void> SignOut();
  Future<String> SignInWithEmailPassword();
  Future<String> CreateUserWithEmailPassword();
  Future<void> SendEmailVerification();
  Future<bool> IsEmailVerified();
}