
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

class FormAuthEmail extends StatelessWidget {
  FormAuthEmail({
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
      child: TextFormField(
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
            return 'Please enter an e-mail';
          }
          if (!EmailValidator.validate(val)) {
            return 'Please enter a valide e-mail.';
          }

          return null;
        },
        onSaved: (value) {
          if (value == null || value.isEmpty) return;
          getter(value.trim());
        },
      ),
    );
  }
}
