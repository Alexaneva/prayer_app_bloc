import 'package:flutter/cupertino.dart';

class AuthTextEditingControllers {
  static final signInEmail = TextEditingController();
  static final signInPassword = TextEditingController();
  static final signUpName = TextEditingController();
  static final signUpEmail = TextEditingController();
  static final signUpPassword = TextEditingController();
  static final signUpConfirmPassword = TextEditingController();

  static bool get isFormFilled {
    return signInEmail.text.isNotEmpty && signInPassword.text.isNotEmpty;
  }
}
