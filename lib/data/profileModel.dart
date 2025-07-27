import 'package:gender_picker/source/enums.dart';
import 'package:studee_app/data/mood.dart';

class ProfileModel {
  ProfileModel({
    this.firstName,
    this.lastName,
    this.myGender,
    this.mySubjectOfInterest,
    this.chosenUniversities,
    this.gpa,
    this.budget,
    this.mood,
  });
  String? firstName;
  String? lastName;
  Gender? myGender;
  String? mySubjectOfInterest;
  List<String>? chosenUniversities;
  double? gpa;
  var budget;
  Mood? mood;

  void setFirstName(String x) {
    firstName = x;
  }

  void setLastName(String x) {
    lastName = x;
  }

  void setGender(Gender gender) {
    myGender = gender;
  }

  void setInterest(String? x) {
    mySubjectOfInterest = x;
  }

  void setUnivs(List<String>? x) {
    chosenUniversities = x;
  }

  void setGPA(double? x) {
    gpa = x;
  }

  void setBudget(dynamic x) {
    budget = x;
  }

  void setMood(Mood? x) {
    mood = x;
  }
}
