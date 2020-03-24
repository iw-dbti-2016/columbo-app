class Validator {
  final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  final RegExp nameRegExp = RegExp(r"^[A-Za-z-']+$");
  final RegExp usernameRegExp = RegExp(r"^[A-Za-z0-9-.]+$");

  String email(String value) {
    if (value.isEmpty) {
      return 'An email is required';
    }

    if (! emailRegExp.hasMatch(value)) {
      return 'The email address must be valid';
    }

    return null;
  }

  String password(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String firstName(String value) {
    if (value.length < 2) {
      return 'First Name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'First Name must be maximum 50 characters';
    }

    if (! nameRegExp.hasMatch(value)) {
      return 'First Name can only contain letters, - and \'';
    }

    return null;
  }

  String lastName(String value) {
    if (value.length < 2) {
      return 'Last Name must be at least 2 characters';
    }

    if (value.length > 50) {
      return 'Last Name must be maximum 50 characters';
    }

    if (! nameRegExp.hasMatch(value)) {
      return 'Last Name can only contain letters, - and \'';
    }

    return null;
  }

  String username(String value) {
    if (value.length < 4) {
      return 'Username must be at least 4 characters';
    }

    if (value.length > 40) {
      return 'Username must be maximum 40 characters';
    }

    if (! usernameRegExp.hasMatch(value)) {
      return 'Username can only contain letters, numbers, - and .';
    }

    return null;
  }
}
