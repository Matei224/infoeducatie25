import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/data/database.dart';
import 'package:studee_app/widgets/signUp_form.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    super.key,
    required this.onPressedok,
    required this.form,
    required this.submit,
    required this.getterEmail,
    required this.getterPassword,
    required this.getterUsername,
    required this.isLogin,
  });
  void Function() onPressedok;
  final form;
  void Function() submit;
  String? Function(String x) getterEmail;
  String? Function(String x) getterPassword;
  String? Function(String x) getterUsername;
  bool isLogin;

  @override
  Widget build(BuildContext context) {
    print(test);
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 104),
        Padding(
          padding: EdgeInsets.only(left: 8, right: 8),

          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 81, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
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
                        'Log in',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 81, 0),
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
          child: signUpForm(
            isLogin: isLogin,
            getterEmail: getterEmail,
            getterPassword: getterPassword,
            getterUsername: getterUsername,
            form: form,
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: size.width * 0.30,
          height: size.height * 0.05,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(
                Color.fromARGB(255, 255, 81, 0),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),

            onPressed: submit,
            child: Text(
              'Sign up',
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
        const SizedBox(height: 16),
      ],
    );
  }
}
