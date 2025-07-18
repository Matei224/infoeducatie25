import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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


Future<void> _signInWithGoogle() async {
  final googleUser = GoogleSignIn()
    try {
      if (googleUser == null) {
        return; // User canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        final user = userCredential.user;
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': user.email,
            'username': user.displayName ?? 'User_${user.uid.substring(0, 5)}',
          });
          firstSignUp(); // Notify parent widget, consistent with signup
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in with Google.')),
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
      return null; // Indicates an error occurred
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

    //Sign up data

    return Scaffold(
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
