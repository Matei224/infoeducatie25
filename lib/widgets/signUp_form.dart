import 'package:flutter/material.dart';
import 'package:studee_app/widgets/formSignUp/form_email.dart';
import 'package:studee_app/widgets/formSignUp/form_password.dart';
import 'package:studee_app/widgets/formSignUp/form_username.dart';
import 'package:studee_app/widgets/form_field.dart';

class signUpForm extends StatefulWidget {
  signUpForm({
    super.key,
    required this.form,
    required this.getterEmail,
    required this.getterPassword,
    required this.getterUsername,
    required this.isLogin,
  });
  final form;
  String? Function(String x) getterEmail;
  String? Function(String x) getterPassword;
  String? Function(String x) getterUsername;
  bool isLogin;

  @override
  State<signUpForm> createState() => _signUpFormState();
}

class _signUpFormState extends State<signUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.form,
      child: Column(
        children: [
          FormAuthUsername(
            getter: widget.getterUsername,
            icon: Icon(
              Icons.person_2_outlined,
              color: Color.fromARGB(100, 0, 0, 0),
            ),
            labelText: 'Username',
          ),
          const SizedBox(height: 16),
          FormAuthEmail(
            isLogin: widget.isLogin,

            getter: widget.getterEmail,
            icon: Icon(
              Icons.email_outlined,
              color: Color.fromARGB(100, 0, 0, 0),
            ),
            labelText: 'Email address',
          ),
          const SizedBox(height: 16),
          FormAuthPassword(
            isLogin: widget.isLogin,
            getter: widget.getterPassword,
            icon: Icon(
              Icons.lock_outline_sharp,
              color: Color.fromARGB(100, 0, 0, 0),
            ),
            labelText: 'Password',
          ),
        ],
      ),
    );
  }
}
