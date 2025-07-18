import 'package:flutter/material.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/form_universities.dart';
import 'package:studee_app/widgets/form_birthday.dart';
import 'package:studee_app/widgets/form_budget.dart';
import 'package:studee_app/widgets/form_dropdown_list.dart';
import 'package:studee_app/widgets/form_field_introduction.dart';
import 'package:studee_app/widgets/form_mood.dart';

class PageWidgetModal extends StatelessWidget {
  PageWidgetModal({
    super.key,
    required this.text,
    required this.span,
    required this.swipe,
    this.form1,
    this.form2,
    this.form_gender,
    this.form_birth,
    this.form_interest,
    this.form_universities,
    this.sliderTheme,
    this.studee,
    this.subtext,
    this.formBudget,
    this.formMood,
    this.form_key_name,
  });

  final String? text;
  final String? span;
  final String? swipe;
  FormIntroduction? form1;
  FormIntroduction? form2;
  GenderPickerWithImage? form_gender;
  FormBirthday? form_birth;
  FormDropDown? form_interest;
  FormUniversities? form_universities;
  final String? studee;
  final String? subtext;
  SizedBox? sliderTheme;
  FormBudget? formBudget;
  FormMood? formMood;
  final form_key_name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.12,
                right: size.width * 0.18,
              ),
              child: Image.asset(
                "assets/images/logo.png",
                width: size.width * 0.20,
                height: size.height * 0.030,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 68),
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.12,
                right: size.width * 0.18,
              ),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: text,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "$studee\n",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        TextSpan(
                          text: subtext,
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.05),
                  if (sliderTheme != null) Center(child: sliderTheme!),
                  if (formBudget != null) formBudget!,
                  if (form_universities != null) form_universities!,
                  if (form_interest != null) form_interest!,
                  if (form_birth != null) form_birth!,
                  if (form1 != null && form2 != null)
                    Form(
                      key: form_key_name,
                      child: Column(children: [form1!, form2!]),
                    ),
                  const SizedBox(height: 16),
                  if (form_gender != null) form_gender!,

                  if (formMood != null) formMood!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
