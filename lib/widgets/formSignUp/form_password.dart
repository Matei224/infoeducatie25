import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:show_hide_password/show_hide_password.dart';

class FormAuthPassword extends StatelessWidget {
  FormAuthPassword({
    super.key,
    required this.icon,
    required this.labelText,
    required this.getter,
    required this.isLogin,
  });
  final Icon? icon;
  final String? labelText;
  String? Function(String x) getter;
  bool isLogin;

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String? enteredPasssword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 60,
      width: size.width * 0.68,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(8.0), // Uniform radius
      ),
      child: ShowHidePassword(
        hidePassword: true,
        passwordField: (hidePassword) {
          return TextFormField(
            obscureText: hidePassword,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Color.fromARGB(200, 0, 0, 0),
                fontSize: 16,
              ),
            ),
            decoration: InputDecoration(
              labelText: labelText,
              icon: Padding(padding: EdgeInsets.only(left: 10), child: icon),
              labelStyle: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Color.fromARGB(100, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter a password.';
              }
              val = val.trim();
              if (isLogin == false) {
                RegExp regexUpperCase = RegExp(r'[A-Z]');
                if (!regexUpperCase.hasMatch(val)) {
                  return 'at least one upper case';
                }
                RegExp regexLowerCase = RegExp(r'[a-z]');
                if (!regexLowerCase.hasMatch(val)) {
                  return 'at least one lower case';
                }
                RegExp regexDigit = RegExp(r'[0-9]');
                if (!regexDigit.hasMatch(val)) {
                  return 'at least one digit';
                }

                RegExp regexSpecialChar = RegExp(r'[!@#\$&*~]');
                if (!regexSpecialChar.hasMatch(val)) {
                  return 'at least one special character';
                }

                RegExp regexLength = RegExp(r'^.{8,}$');
                if (!regexLength.hasMatch(val)) {
                  return 'at least 8 characters';
                }
              }
              return null;
            },
            onSaved: (value) {
              getter(value!.trim());
            },
          );
        },
      ),
    );
  }
}
