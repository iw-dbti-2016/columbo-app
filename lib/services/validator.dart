class Validator {
  final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

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
    // TODO: implement
    return null;
  }

  String lastName(String value) {
    // TODO: implement
    return null;
  }

  String username(String value) {
    // TODO: implement
    return null;
  }
}
