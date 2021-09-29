import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';

class AuthenticationTextField extends StatelessWidget {
  AuthenticationTextField({
    required this.handleChange,
    required this.fieldType,
  });

  final String fieldType;
  final Function handleChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: TextStyle(color: kTextLight),
          keyboardType: fieldType == 'email'
              ? TextInputType.emailAddress
              : TextInputType.text,
          obscureText: fieldType == 'password',
          textAlign: TextAlign.center,
          onChanged: (value) {
            handleChange(value);
          },
          decoration: kTextFieldDecoration.copyWith(
            hintText: fieldType == 'password-confirm'
                ? 'Confirm your password'
                : 'Enter your $fieldType',
          ),
        ),
      ],
    );
  }
}
