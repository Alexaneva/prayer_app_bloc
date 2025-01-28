import 'package:flutter/material.dart';

import '../../../text_editing_сontrollers/auth_text_editing_сontrollers.dart';
import '../../../validation/auth_validation.dart';


class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final FieldType fieldType;
  final Widget? suffixIcon;
  final bool isObscureText;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.fieldType,
    this.suffixIcon,
    this.isObscureText = true,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

enum FieldType { signInEmail, signInPassword, name, email, password, confirmPassword }

class _CustomInputFieldState extends State<CustomInputField> {
  String? _validationMessage;
  bool _isObscuredText = true;
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    _validationMessage = null;
  }

  void _validateInput(String value) {
    setState(() {
      _hasInteracted = true;
      switch (widget.fieldType) {
        case FieldType.signInEmail:
          _validationMessage = AuthValidation.validateEmail(value);
          break;
        case FieldType.signInPassword:
          _validationMessage = AuthValidation.validatePassword(value);
          break;
        case FieldType.name:
          _validationMessage = AuthValidation.validateName(value);
          break;
        case FieldType.email:
          _validationMessage = AuthValidation.validateEmail(value);
          break;
        case FieldType.password:
          _validationMessage = AuthValidation.validatePassword(value);
          break;
        case FieldType.confirmPassword:
          _validationMessage = AuthValidation.validateConfirmPassword(
            value,
            AuthTextEditingControllers.signUpPassword.text,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = _validationMessage == null
        ? Colors.grey
        : (_validationMessage!.isEmpty ? Colors.green : Colors.red);
    Color textColor;
    if (widget.fieldType == FieldType.email || widget.fieldType == FieldType.confirmPassword) {
      textColor = (_hasInteracted && (_validationMessage == null || _validationMessage!.isEmpty))
          ? Colors.green
          : Colors.grey;
    } else {
      textColor = Colors.grey;
    }

    return TextFormField(
      obscureText: widget.isObscureText ? _isObscuredText : false,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.labelText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        errorText: _validationMessage?.isNotEmpty == true
            ? _validationMessage
            : null,
        suffixIcon: _getSuffixIcon(),
      ),
      style: TextStyle(color: textColor),
      onChanged: (value) {
        _validateInput(value);
        setState(() {});
      },
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.fieldType == FieldType.signInPassword ||
        widget.fieldType == FieldType.password) {
      Color iconColor = (_validationMessage != null && _validationMessage!.isNotEmpty)
          ? Colors.red
          : Colors.grey;
      return IconButton(
        icon: Icon(
          _isObscuredText ? Icons.visibility_off : Icons.visibility,
          color: iconColor,
        ),
        onPressed: () {
          setState(() {
            _isObscuredText = !_isObscuredText;
          });
        },
      );
    }
    else if (widget.fieldType == FieldType.email) {
      if (_hasInteracted) {
        return (_validationMessage == null || _validationMessage!.isEmpty)
            ? Icon(Icons.check, color: Colors.green)
            : null;
      }
      return null;
    }
    else if (widget.fieldType == FieldType.confirmPassword) {
      if (_hasInteracted) {
        return (_validationMessage == null || _validationMessage!.isEmpty)
            ? Icon(Icons.check, color: Colors.green)
            : IconButton(
          icon: Icon(
            _isObscuredText ? Icons.visibility_off : Icons.visibility,
            color: Colors.red,
          ),
          onPressed: () {
            setState(() {
              _isObscuredText = !_isObscuredText;
            });
          },
        );
      }
      return null;
    }
    return null;
  }

}