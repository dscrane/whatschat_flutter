import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';

class AuthenticationTextField extends StatelessWidget {
  AuthenticationTextField({
    required this.handleChange,
    required this.fieldType,
    this.isRegistration = true,
    this.initialValue,
  });

  final String fieldType;
  final Function handleChange;
  final bool isRegistration;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController =
        initialValue != null ? TextEditingController(text: initialValue) : TextEditingController();
    final InputDecoration decorationStyle =
        !isRegistration ? kTextFieldDecoration : kRegistrationTextFieldDecoration;

    return Column(
      children: <Widget>[
        TextFormField(
          controller: textController,
          style: TextStyle(color: kTextLight),
          keyboardType: fieldType == 'email' ? TextInputType.emailAddress : TextInputType.text,
          obscureText: fieldType == 'password' || fieldType == 'password-confirm',
          textAlign: TextAlign.center,
          onChanged: (value) {
            handleChange(value);
          },
          decoration: decorationStyle.copyWith(
            hintText:
                fieldType == 'password-confirm' ? 'Confirm your password' : 'Enter your $fieldType',
          ),
        ),
      ],
    );
  }
}
