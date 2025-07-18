import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/gpabox.dart';
import 'package:studee_app/model/profileChangeUniv.dart';
import 'package:studee_app/model/profileModel.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  ProfileModel? person;
  bool isEdit = false;

  bool isLoading = true;
  String? gpa;
  final formGpa = GlobalKey<FormState>();
  Future<void> fetchProfileData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() {
            person = ProfileModel(
              firstName: data['firstName'],
              lastName: data['lastName'],
              gpa: data['gpa'] != null ? double.tryParse(data['gpa']) : null,
              chosenUniversities:
                  data['topUnivs'] != null
                      ? List<String>.from(data['topUnivs'])
                      : null,
              mySubjectOfInterest: data['subject'],
            );
            isLoading = false; // Data is ready, stop loading
          });
        } else {
          setState(() {
            isLoading = false; // No data, stop loading
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Error occurred, stop loading
      });
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  void setGpa(String gp) {
    gpa = gp;
  }

  void toggleTextField() async {
    setState(() {
      isEdit = true;
    });
    setEdit;
  }

  void setEdit(bool setEdit) {
    setState(() {
      setEdit = isEdit;
    });
  }

  void submitGpa() async {
    if (formGpa.currentState!.validate()) {
      formGpa.currentState!.save();
      setGpa; // Triggers onSaved
      if (gpa != null) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'gpa': gpa});
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('GPA updated successfully')));
          setState(() {
            isEdit = false;
          });
          setEdit;
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error updating GPA: $e')));
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${person?.firstName ?? ''} ${person?.lastName ?? ''}",
                      style: GoogleFonts.raleway(
                        fontSize: 24,
                        color: Color.fromARGB(255, 115, 0, 255),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 1.5,
                      width: 160,
                      color: Color.fromARGB(255, 194, 194, 194),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.2,
                              color: Color.fromARGB(255, 115, 0, 255),
                            ),
                            color: Color.fromARGB(255, 255, 251, 238),
                          ),

                          child: Icon(
                            person?.myGender == Gender.Male
                                ? Icons.male
                                : (person?.myGender == Gender.Female
                                    ? Icons.female
                                    : Icons.transgender),
                            color: Color.fromARGB(255, 115, 0, 255),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          person!.mySubjectOfInterest!,
                          style: GoogleFonts.raleway(
                            fontSize: 12,
                            color: Color.fromARGB(255, 115, 0, 255),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Text(
                        "Top 3 choices",
                        style: GoogleFonts.raleway(
                          fontSize: 10,
                          color: Color.fromARGB(255, 115, 0, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    ProfileUniv(univ: person!.chosenUniversities![0], index: 0),
                    const SizedBox(height: 14),
                    ProfileUniv(univ: person!.chosenUniversities![1], index: 1),
                    const SizedBox(height: 14),
                    ProfileUniv(univ: person!.chosenUniversities![2], index: 2),
                    const SizedBox(height: 14),

                    Center(
                      child: Text(
                        "GPA",
                        style: GoogleFonts.raleway(
                          fontSize: 10,
                          color: Color.fromARGB(255, 115, 0, 255),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    GpaBox(
                      gpa: person!.gpa!.toString(),
                      form: formGpa,
                      isEdit: isEdit,
                      setGpa: setGpa,
                      setEdit: setEdit,
                    ),
                    const SizedBox(height: 15),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.25,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromARGB(255, 115, 0, 255),
                              // Uniform radius
                            ),
                            padding: EdgeInsets.all(2),
                            child: TextButton(
                              onPressed: logOut,
                              child: Text(
                                "Log out",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 81, 0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),

                            child: TextButton(
                              onPressed: () {},
                              child:
                                  !isEdit
                                      ? TextButton(
                                        onPressed: toggleTextField,
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                      : TextButton(
                                        onPressed: submitGpa,
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(color: Colors.white),
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
    );
  }
}
