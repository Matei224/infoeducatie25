

import 'dart:convert';

List<University> universityFromJson(String str) =>
    List<University>.from(json.decode(str).map((x) => University.fromJson(x)));
class University {
  final int? id;
  final String name;
  final String city;
  final String country;
  final String urlImage;
  final String degree;
  final String programme;
  final String? fullName;
  final String? duration;
  final String? money;
  final String? language;
  final String? data;
  final String? urlLogo;
  final String alphaTwoCode;
  final List<String> webPages;

  University({
    this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.urlImage,
    required this.degree,
    required this.programme,
    required this.data,
    required this.duration,
    required this.fullName,
    required this.language,
    required this.money,
    required this.urlLogo,    
    required this.alphaTwoCode,
    required this.webPages,

  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'country': country,
      'urlImage': urlImage,
      'degree': degree,
      'programme': programme,
      'money': money,
      'language': language,
      'fullName': fullName,
      'data': data,
      'duration': duration,
      'urlLogo': urlLogo,
      'webPages': jsonEncode(webPages),
       'alphaTwoCode':alphaTwoCode
    };
  }

  factory University.fromMap(Map<String, dynamic> map) {
    return University(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      country: map['country'],
      urlImage: map['urlImage'],
      degree: map['degree'],
      programme: map['programme'],
      money: map['money'],
      language: map['language'],
      fullName: map['fullName'],
      data: map['data'],
      duration: map['duration'],
      urlLogo: map['urlLogo'],
webPages: map['webPages'] != null
          ? List<String>.from(jsonDecode(map['webPages']))
          : [],    
alphaTwoCode: map['alphaTwoCode']
    );
  }

  
  factory University.fromJson(Map<String, dynamic> json) => University(
    name: json["name"] ?? "Unknown", // Name from JSON, with fallback
    city: "Hardcoded City",
        country: json["country"] ?? 'XXXXX',
    urlImage: "https://example.com/hardcoded-image.jpg",
    degree: "Hardcoded Degree",
    programme: "Hardcoded Programme",
    data: "Hardcoded Data",
    duration: "Hardcoded Duration",
    fullName: "Hardcoded Full Name",
    language: "Hardcoded Language",
    money: "Hardcoded Money",
    urlLogo: "https://example.com/hardcoded-logo.png",
        alphaTwoCode: json["alpha_two_code"] ?? 'XX',
webPages: json["web_pages"] != null
            ? List<String>.from(json["web_pages"].map((x) => x))
            : [], );
}
   


