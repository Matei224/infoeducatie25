import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/widgets/formSignUp/form_email.dart';
import 'package:studee_app/widgets/form_field.dart';
import 'package:studee_app/widgets/login.dart';
import 'package:studee_app/widgets/signup.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key, this.firstSignUp});
  bool? firstSignUp;

  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  bool isLogin = true;
  String enteredPassword = '';
  String enteredEmail = '';
  String enteredUsername = '';
  bool isAuth = false;
  String encryptedPassword = '';

  void forgotPassword() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      try {
        await _firebase.sendPasswordResetEmail(email: enteredEmail);
      } on FirebaseAuthException catch (err) {
        throw Exception(err.message.toString());
      } catch (err) {
        throw Exception(err.toString());
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('E-mail is not valid')));
    }
  }

  final _form = GlobalKey<FormState>();

  @override
  void signUp() {
    setState(() {
      isLogin = false;
    });
    _form.currentState!.reset();
  }

  void login() {
    setState(() {
      isLogin = true;
    });
    _form.currentState!.reset();
  }

  Future<bool?> isEmailRegistered(String email) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      List<String> methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return null; // Indicates an error occurred
    }
  }

  void firstSignUp() {
    widget.firstSignUp = true;
  }

  void submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {}
    _form.currentState!.save();
    print('Email $enteredEmail');
    print('Password $enteredPassword');
    print('Username $enteredUsername');

    encryptedPassword = encryptPassword(enteredPassword);

    setState(() {
      isAuth = true;
    });

    if (isLogin == false) {
      try {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: enteredEmail,
          password: encryptedPassword,
        );
        setState(() {
          firstSignUp();
        });
      } on FirebaseAuthException catch (err) {
        if (err.code == 'email-already-in-use') {
          print('nu mere');
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        if (await isEmailRegistered(enteredEmail) == false)
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('E-mail already exists.')));
        else
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.message ?? 'Authentification failed.')),
          );
        setState(() {
          isAuth = false;
        });
      }
    } else {
      try {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: enteredEmail,
          password: encryptedPassword,
        );
      } on FirebaseAuthException catch (err) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(err.message ?? 'Authentification failed.')),
        );
        setState(() {
          isAuth = false;
        });
      }
    }
  }

  String encryptPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  String? getterEmail(String x) {
    enteredEmail = x;
  }

  String? getterPassword(String x) {
    enteredPassword = x;
  }

  String? getterUsername(String x) {
    enteredUsername = x;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double widthScreen = size.width;

    //Sign up data

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bkg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SafeArea(
            top: true,

            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: size.width * 0.28,
                  height: size.height * 0.035,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: size.width * 0.15,
                    right: size.width * 0.15,
                  ),
                  child:
                      isLogin
                          ? LoginForm(
                            resetPassword: forgotPassword,
                            form: _form,
                            submit: submit,
                            isLogin: isLogin,
                            onPressedok: signUp,
                            getterEmail: getterEmail,
                            getterPassword: getterPassword,
                          )
                          : SignUpForm(
                            isLogin: isLogin,
                            getterEmail: getterEmail,
                            getterPassword: getterPassword,
                            getterUsername: getterUsername,
                            onPressedok: login,
                            form: _form,
                            submit: submit,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
