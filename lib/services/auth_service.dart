import 'package:Columbo/models/user.dart';

abstract class AuthService {
  /// Registers a user on the server and returns
  ///   the User-object of the new user.
  Future<User> register(String email, String password, String pwConfirm,
      String username, String firstName, String lastName);

  /// Logs the user in on the server and returns
  ///   the User-object of the user.
  Future<User> login(String email, String password);

  /// Returns the user that is currently authenticated
  ///   or returns null if no user is authenticated.
  User get user;

  /// Fetches the user from the server, even is the
  ///   user is already saved locally or in cache.
  Future<User> fetchUser();

  /// Returns the currently authenticated user's
  ///   token or returns null if no user is authenticated.
  String get token;

  /// Refreshes the token by requesting a new token
  ///   from the server.
  Future<bool> refreshToken();

  /// Requests the server to resend the email-
  ///   verification email to the authenticated user.
  Future<bool> resendEmailVerification();

  /// Requests the server to send an email to the user
  ///   with given email address to reset their password.
  Future<bool> sendPasswordResetEmail(String email);

  /// Logs the authenticated user out on the server.
  Future<bool> logout();
}
