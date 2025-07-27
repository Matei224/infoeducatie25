import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {
  final VoidCallback onVerified;

  const WaitingScreen({super.key, required this.onVerified, required Future<Null> Function() onCheckVerification});

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    checkVerification();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkVerification();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> checkVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        _timer?.cancel();
        widget.onVerified();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 251, 238),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Waiting for validation...',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
