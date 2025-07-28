import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLink extends StatelessWidget {
  const UrlLink({super.key, required this.text});
  final text;
  _launchURL() async {
    Uri _url = Uri.parse(text);
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
