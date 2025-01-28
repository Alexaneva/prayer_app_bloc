class AuthValidation {

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter correct name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter correct email';
    }
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter correct email';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.length < 5) {
      return 'Password field must be at least 5 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String value, String password) {
    if (value != password) {
      return 'Passwords must match';
    }
    return null;
  }
}
