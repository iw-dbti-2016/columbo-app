import 'package:Columbo/models/user.dart';

abstract class AuthService {
  Future<User> currentUser();

  Future<String> retrieveToken();

  Future<bool> refreshToken();

  Future<User> signInWithEmailAndPassword(String email, String password);

  Future<User> createUserWithEmailAndPassword(String email, String password,
      String pwConfirm, String username, String firstName, String lastName);

  Future<bool> sendPasswordResetEmail(String email);

  Future<bool> resendEmailVerification();

  Future<bool> signOut();

  Stream<User> get onAuthStateChanged;
}
