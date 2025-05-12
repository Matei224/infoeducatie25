import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/widgets/formSignUp/form_email.dart';
import 'package:studee_app/widgets/formSignUp/form_password.dart';
import 'package:studee_app/widgets/form_field.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
    required this.isLogin,
    required this.onPressedok,
    required this.getterEmail,
    required this.getterPassword,
    required this.submit,
    required this.form,
    required this.resetPassword,
  });
  bool isLogin;
  final form;

  void Function() onPressedok;
  void Function() submit;
  String? Function(String x) getterEmail;
  String? Function(String x) getterPassword;
  void Function() resetPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 104),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),

          child: Column(
            children: [
              Align(
                child: Text(
                  'Log in',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 115, 0, 255),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                alignment: Alignment.topLeft,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: onPressedok,
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 115, 0, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.topLeft,
          child: Form(
            key: form,
            child: Column(
              children: [
                FormAuthEmail(
                  isLogin: isLogin,
                  getter: getterEmail,
                  icon: Icon(
                    Icons.email_outlined,
                    color: Color.fromARGB(100, 0, 0, 0),
                  ),
                  labelText: 'Email adress',
                ),
                const SizedBox(height: 16),
                FormAuthPassword(
                  isLogin: isLogin,
                  getter: getterPassword,
                  icon: Icon(
                    Icons.lock_outline_sharp,
                    color: Color.fromARGB(100, 0, 0, 0),
                  ),
                  labelText: 'Password',
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot your password?',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: resetPassword,
              child: Text(
                'Reset it',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 115, 0, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: size.width * 0.30,
          height: size.height * 0.05,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                Color.fromARGB(255, 115, 0, 255),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            onPressed: submit,
            child: Text(
              'Log in',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
