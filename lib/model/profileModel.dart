import 'package:gender_picker/source/enums.dart';
import 'package:studee_app/model/mood.dart';

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
    this.firstName = x;
  }

  void setLastName(String x) {
    this.lastName = x;
  }

  void setGender(Gender gender) {
    this.myGender = gender;
  }

  void setInterest(String? x) {
    this.mySubjectOfInterest = x;
  }

  void setUnivs(List<String>? x) {
    this.chosenUniversities = x;
  }

  void setGPA(double? x) {
    this.gpa = x;
  }

  void setBudget(dynamic x) {
    this.budget = x;
  }

  void setMood(Mood? x) {
    this.mood = x;
  }
}
