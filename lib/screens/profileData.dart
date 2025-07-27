import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/widgets/model/gpabox.dart';
import 'package:studee_app/widgets/model/profileChangeUniv.dart';
import 'package:studee_app/data/profileModel.dart';

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
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          setState(() {
            person = ProfileModel(
              firstName: data['firstName'],
              lastName: data['lastName'],
              gpa: data['gpa'] != null ? double.tryParse(data['gpa']) : null,
              chosenUniversities:
                  data['topUnivs'] != null ? List<String>.from(data['topUnivs']) : null,
              mySubjectOfInterest: data['subject'],
            );
            isLoading = false; 
          });
        } else {
          setState(() {
            isLoading = false; 
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false; 
      });
      print('Error fetching profile data: $e');
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  void setGpa(String gp) {
    setState(() {
      gpa = gp; 
      if (person != null) {
        person!.setGPA(double.tryParse(gp)); 
      }
    });
  }

  void toggleTextField() async {
    if (mounted) {
      setState(() {
        isEdit = true;
      });
      setEdit(false); 
    }
  }

  void setEdit(bool setEdit) {
    if (mounted) {
      setState(() {
        isEdit = setEdit; 
      });
    }
  }

  Future<void> submitGpa() async {
    if (!mounted) return; 
    if (formGpa.currentState!.validate()) {
      formGpa.currentState!.save();
      print('GPA after save: $gpa'); 
      if (gpa != null) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
    
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({'gpa': gpa});
           
              await fetchProfileData(); 
              setState(() {
                isEdit = false;
              });
              setEdit(false); 
            
          
        } else if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User not authenticated')));
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('GPA is null, update failed')));
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Validation failed')));
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
      child: isLoading
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
                  if (person?.chosenUniversities != null &&
                      person!.chosenUniversities!.length > 0)
                    ProfileUniv(univ: person!.chosenUniversities![0], index: 0),
                  const SizedBox(height: 14),
                  if (person?.chosenUniversities != null &&
                      person!.chosenUniversities!.length > 1)
                    ProfileUniv(univ: person!.chosenUniversities![1], index: 1),
                  const SizedBox(height: 14),
                  if (person?.chosenUniversities != null &&
                      person!.chosenUniversities!.length > 2)
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
                    gpa: person!.gpa?.toString() ?? '0.0',
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
                            onPressed: submitGpa,
                            child: !isEdit
                                ? TextButton(
                                    onPressed: toggleTextField,
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
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