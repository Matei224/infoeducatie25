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
    );
  }
}
