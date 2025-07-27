import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studee_app/model/google_button.dart';
import 'package:studee_app/widgets/login.dart';
import 'package:studee_app/widgets/signup.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key, required this.onTrue});
  void Function(bool x) onTrue;

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
          _form.currentState!.save();

      try {
        await _firebase.sendPasswordResetEmail(email: enteredEmail.trim());
          ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Reset link has been sent.')));
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


void _signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      
      if (!userDoc.exists) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'username': user.displayName ?? 'User_${user.uid.substring(0, 5)}',
          'onboardingCompleted': false, 
        });
        firstSignUp(); 
      }
    }
  } catch (e) {
    print('Error signing in with Google: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to sign in with Google: $e')),
    );
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
      final FirebaseAuth auth = FirebaseAuth.instance;
      List<String> methods = await auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      print('Error checking email: $e');
      return null; 
    }
  }

  void firstSignUp() {
    widget.onTrue(true);
  }

  void submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;
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
        firstSignUp();

        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredentials.user!.uid)
              .set({'email': enteredEmail, 'username': enteredUsername});
          print('ok');
        } catch (e) {
          print(e);
        }
        await userCredentials.user!.sendEmailVerification();
      } on FirebaseAuthException catch (err) {
        if (err.code == 'email-already-in-use') {
          print('nu mere');
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        if (await isEmailRegistered(enteredEmail) == false) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('E-mail already exists.')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(err.message ?? 'Authentification failed.')),
          );
        }
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
    return null;
  }

  String? getterPassword(String x) {
    enteredPassword = x;
    return null;
  }

  String? getterUsername(String x) {
    enteredUsername = x;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double widthScreen = size.width;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                isLogin
                    ? AssetImage("assets/images/bkg.png")
                    : AssetImage("assets/images/signup.png"),
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
                          ? Column(
                            children: [
                              LoginForm(
                                resetPassword: forgotPassword,
                                form: _form,
                                submit: submit,
                                isLogin: isLogin,
                                onPressedok: signUp,
                                getterEmail: getterEmail,
                                getterPassword: getterPassword,
                              ),
                              GoogleButton(func:_signInWithGoogle)
                            ],
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
