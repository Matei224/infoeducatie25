import 'dart:convert';

import 'package:studee_app/data/university_data.dart';

List<ActualUniveristy> ActualUniveristyFromJson(String str) =>
    List<ActualUniveristy>.from(json.decode(str).map((x) => ActualUniveristy.fromJson(x)));

class ActualUniveristy {
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
  final String? urlLogo;
  final String alphaTwoCode;
  final List<String> webPages;
  final String abreviation;
  final String graduationRate;
  final String employabilityRate;
  final String retentionRate;
  final String rank;
  final String extracurricularClubs;
  final String undergraduateProgrammes;
  final String academicsDescription;
  final String homePageUrl;
  final String academicsMapsLocationUrl;

  final String averageCostPerYear;
  final String studentsReceivingFinancialAidPercentage;
  final String financialAidApplicationDate;

  final String housingFoundRate;
  final String housingPricePerYear;
  final String taxesCostPerYear;
  final String suppliesCostPerYear;
  final String lifeDescription;
  final String costsPageUrl;
  final String lifeMapsLocationUrl;
  final String numbeoPropertyPricesUrl;
  final String numbeoGoodsAndServicesPricesUrl;
  final String numbeoFoodPricesUrl;

  final String acceptanceRate;
  final String englishRequirements;
  final String otherLanguages;
  final String examBased;
  final String portfolioBased;
  final String bacNeeded;
  final String averageGpaEntry;
  final String averageApplicantsNumber;
  final String admissionDates;
  final String admissionsDescription;
  final String admissionsPageUrl;
  final String admissionsMapsLocationUrl;

  final String safetyRate;
  final String averageStudentsNumber;
  final String costPerYear;
  final String campusDescription;
  final String campusPageUrl;
  final String campusMapsLocationUrl;
  final String numbeoCrimeUrl;
  final String numbeoSafetyUrl;


  ActualUniveristy({
    this.id,
    required this.name,
    required this.abreviation,
    required this.city,
    required this.country,
    required this.urlImage,
    required this.degree,
    required this.programme,
    this.fullName,
    this.duration,
    this.money,
    this.language,
    this.urlLogo,
    required this.alphaTwoCode,
    required this.webPages,
    required this.graduationRate,
    required this.employabilityRate,
    required this.retentionRate,
    required this.rank,
    required this.extracurricularClubs,
    required this.undergraduateProgrammes,
    required this.academicsDescription,
    required this.homePageUrl,
    required this.academicsMapsLocationUrl,
    required this.averageCostPerYear,
    required this.studentsReceivingFinancialAidPercentage,
    required this.financialAidApplicationDate,
    required this.housingFoundRate,
    required this.housingPricePerYear,
    required this.taxesCostPerYear,
    required this.suppliesCostPerYear,
    required this.lifeDescription,
    required this.costsPageUrl,
    required this.lifeMapsLocationUrl,
    required this.numbeoPropertyPricesUrl,
    required this.numbeoGoodsAndServicesPricesUrl,
    required this.numbeoFoodPricesUrl,
    required this.acceptanceRate,
    required this.englishRequirements,
    required this.otherLanguages,
    required this.examBased,
    required this.portfolioBased,
    required this.bacNeeded,
    required this.averageGpaEntry,
    required this.averageApplicantsNumber,
    required this.admissionDates,
    required this.admissionsDescription,
    required this.admissionsPageUrl,
    required this.admissionsMapsLocationUrl,
    required this.safetyRate,
    required this.averageStudentsNumber,
    required this.costPerYear,
    required this.campusDescription,
    required this.campusPageUrl,
    required this.campusMapsLocationUrl,
    required this.numbeoCrimeUrl,
    required this.numbeoSafetyUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'country': country,
      'urlImage': urlImage,
      'degree': degree,
      'programme': programme,
      'fullName': fullName,
      'duration': duration,
      'money': money,
      'language': language,
      'urlLogo': urlLogo,
      'alphaTwoCode': alphaTwoCode,
      'webPages': jsonEncode(webPages),
      'graduationRate': graduationRate,
      'employabilityRate': employabilityRate,
      'retentionRate': retentionRate,
      'rank': rank,
      'extracurricularClubs': extracurricularClubs,
      'undergraduateProgrammes': undergraduateProgrammes,
      'academicsDescription': academicsDescription,
      'homePageUrl': homePageUrl,
      'academicsMapsLocationUrl': academicsMapsLocationUrl,
      'averageCostPerYear': averageCostPerYear,
      'studentsReceivingFinancialAidPercentage': studentsReceivingFinancialAidPercentage,
      'financialAidApplicationDate': financialAidApplicationDate,
      'housingFoundRate': housingFoundRate,
      'housingPricePerYear': housingPricePerYear,
      'taxesCostPerYear': taxesCostPerYear,
      'suppliesCostPerYear': suppliesCostPerYear,
      'lifeDescription': lifeDescription,
      'costsPageUrl': costsPageUrl,
      'lifeMapsLocationUrl': lifeMapsLocationUrl,
      'numbeoPropertyPricesUrl': numbeoPropertyPricesUrl,
      'numbeoGoodsAndServicesPricesUrl': numbeoGoodsAndServicesPricesUrl,
      'numbeoFoodPricesUrl': numbeoFoodPricesUrl,
      'acceptanceRate': acceptanceRate,
      'englishRequirements': englishRequirements,
      'otherLanguages': otherLanguages,
      'examBased': examBased,
      'portfolioBased': portfolioBased,
      'bacNeeded': bacNeeded,
      'averageGpaEntry': averageGpaEntry,
      'averageApplicantsNumber': averageApplicantsNumber,
      'admissionDates': admissionDates,
      'admissionsDescription': admissionsDescription,
      'admissionsNếuPageUrl': admissionsPageUrl,
      'admissionsMapsLocationUrl': admissionsMapsLocationUrl,
      'safetyRate': safetyRate,
      'averageStudentsNumber': averageStudentsNumber,
      'costPerYear': costPerYear,
      'campusDescription': campusDescription,
      'campusPageUrl': campusPageUrl,
      'campusMapsLocationUrl': campusMapsLocationUrl,
      'numbeoCrimeUrl': numbeoCrimeUrl,
      'numbeoSafetyUrl': numbeoSafetyUrl,
      'abreviation':abreviation,
    };
  }

  factory ActualUniveristy.fromMap(Map<String, dynamic> map) {
    return ActualUniveristy(
      id: map['id'],
      abreviation: map['abreviation'] as String? ?? 'Unknown',
      name: map['name'] as String? ?? 'Unknown',
      city: map['city'] as String? ?? 'Unknown',
      country: map['country'] as String? ?? 'Unknown',
      urlImage: map['urlImage'] as String? ?? 'Unknown',
      degree: map['degree'] as String? ?? 'Unknown',
      programme: map['programme']as String? ?? 'Unknown',
      fullName: map['fullName'] as String? ?? 'Unknown',
      duration: map['duration']as String? ?? 'Unknown',
      money: map['money']as String? ?? 'Unknown',
      language: map['language']as String? ?? 'Unknown',
      urlLogo: map['urlLogo'as String? ?? 'Unknown'],
      alphaTwoCode: map['alphaTwoCode']as String? ?? 'Unknown',
      webPages: map['webPages'] != null
          ? List<String>.from(jsonDecode(map['webPages']))
          : [],
      graduationRate: map['graduationRate']as String? ?? 'Unknown',
      employabilityRate: map['employabilityRate']as String? ?? 'Unknown',
      retentionRate: map['retentionRate']as String? ?? 'Unknown',
      rank: map['rank']as String? ?? 'Unknown',
      extracurricularClubs: map['extracurricularClubs']as String? ?? 'Unknown',
      undergraduateProgrammes: map['undergraduateProgrammes']as String? ?? 'Unknown',
      academicsDescription: map['academicsDescription']as String? ?? 'Unknown',
      homePageUrl: map['homePageUrl']as String? ?? 'Unknown',
      academicsMapsLocationUrl: map['academicsMapsLocationUrl']as String? ?? 'Unknown',
      averageCostPerYear: map['averageCostPerYear']as String? ?? 'Unknown',
      studentsReceivingFinancialAidPercentage: map['studentsReceivingFinancialAidPercentage']as String? ?? 'Unknown',
      financialAidApplicationDate: map['financialAidApplicationDate']as String? ?? 'Unknown',
      housingFoundRate: map['housingFoundRate']as String? ?? 'Unknown',
      housingPricePerYear: map['housingPricePerYear']as String? ?? 'Unknown',
      taxesCostPerYear: map['taxesCostPerYear']as String? ?? 'Unknown',
      suppliesCostPerYear: map['suppliesCostPerYear']as String? ?? 'Unknown',
      lifeDescription: map['lifeDescription']as String? ?? 'Unknown',
      costsPageUrl: map['costsPageUrl']as String? ?? 'Unknown',
      lifeMapsLocationUrl: map['lifeMapsLocationUrl']as String? ?? 'Unknown',
      numbeoPropertyPricesUrl: map['numbeoPropertyPricesUrl']as String? ?? 'Unknown',
      numbeoGoodsAndServicesPricesUrl: map['numbeoGoodsAndServicesPricesUrl']as String? ?? 'Unknown',
      numbeoFoodPricesUrl: map['numbeoFoodPricesUrl']as String? ?? 'Unknown',
      acceptanceRate: map['acceptanceRate']as String? ?? 'Unknown',
      englishRequirements: map['englishRequirements']as String? ?? 'Unknown',
      otherLanguages: map['otherLanguages']as String? ?? 'Unknown',
      examBased: map['examBased']as String? ?? 'Unknown',
      portfolioBased: map['portfolioBased']as String? ?? 'Unknown',
      bacNeeded: map['bacNeeded']as String? ?? 'Unknown',
      averageGpaEntry: map['averageGpaEntry']as String? ?? 'Unknown',
      averageApplicantsNumber: map['averageApplicantsNumber']as String? ?? 'Unknown',
      admissionDates: map['admissionDates']as String? ?? 'Unknown',
      admissionsDescription: map['admissionsDescription']as String? ?? 'Unknown',
      admissionsPageUrl: map['admissionsPageUrl']as String? ?? 'Unknown',
      admissionsMapsLocationUrl: map['admissionsMapsLocationUrl']as String? ?? 'Unknown',
      safetyRate: map['safetyRate']as String? ?? 'Unknown',
      averageStudentsNumber: map['averageStudentsNumber']as String? ?? 'Unknown',
      costPerYear: map['costPerYear']as String? ?? 'Unknown',
      campusDescription: map['campusDescription']as String? ?? 'Unknown',
      campusPageUrl: map['campusPageUrl']as String? ?? 'Unknown',
      campusMapsLocationUrl: map['campusMapsLocationUrl']as String? ?? 'Unknown',
      numbeoCrimeUrl: map['numbeoCrimeUrl']as String? ?? 'Unknown',
      numbeoSafetyUrl: map['numbeoSafetyUrl']as String? ?? 'Unknown',
    );
  }

  factory ActualUniveristy.fromJson(Map<String, dynamic> json) => ActualUniveristy(
        name: json["name"] ?? "Unknown",
        city: json["city"] ?? "Hardcoded City",
        country: json["country"] ?? 'XXXXX',
        urlImage: json["urlImage"] ?? "https://example.com/hardcoded-image.jpg",
        degree: json["degree"] ?? "Hardcoded Degree",
        programme: json["programme"] ?? "Hardcoded Programme",
        duration: json["duration"] ?? "Hardcoded Duration",
        fullName: json["fullName"] ?? "Hardcoded Full Name",
        language: json["language"] ?? "Hardcoded Language",
        money: json["money"] ?? "Hardcoded Money",
        abreviation: json["abreviation"]?? "",
        urlLogo: json["urlLogo"] ?? "https://example.com/hardcoded-logo.png",
        alphaTwoCode: json["alpha_two_code"] ?? 'XX',
        webPages: json["web_pages"] != null
            ? List<String>.from(json["web_pages"].map((x) => x))
            : [],
        graduationRate: json["graduationRate"] ?? '',
        employabilityRate: json["employabilityRate"] ?? '',
        retentionRate: json["retentionRate"] ?? '',
        rank: json["rank"] ?? '',
        extracurricularClubs: json["extracurricularClubs"] ?? '',
        undergraduateProgrammes: json["undergraduateProgrammes"] ?? '',
        academicsDescription: json["academicsDescription"] ?? '',
        homePageUrl: json["homePageUrl"] ?? '',
        academicsMapsLocationUrl: json["academicsMapsLocationUrl"] ?? '',
        averageCostPerYear: json["averageCostPerYear"] ?? '',
        studentsReceivingFinancialAidPercentage: json["studentsReceivingFinancialAidPercentage"] ?? '',
        financialAidApplicationDate: json["financialAidApplicationDate"] ?? '',
        housingFoundRate: json["housingFoundRate"] ?? '',
        housingPricePerYear: json["housingPricePerYear"] ?? '',
        taxesCostPerYear: json["taxesCostPerYear"] ?? '',
        suppliesCostPerYear: json["suppliesCostPerYear"] ?? '',
        lifeDescription: json["lifeDescription"] ?? '',
        costsPageUrl: json["costsPageUrl"] ?? '',
        lifeMapsLocationUrl: json["lifeMapsLocationUrl"] ?? '',
        numbeoPropertyPricesUrl: json["numbeoPropertyPricesUrl"] ?? '',
        numbeoGoodsAndServicesPricesUrl: json["numbeoGoodsAndServicesPricesUrl"] ?? '',
        numbeoFoodPricesUrl: json["numbeoFoodPricesUrl"] ?? '',
        acceptanceRate: json["acceptanceRate"] ?? '',
        englishRequirements: json["englishRequirements"] ?? '',
        otherLanguages: json["otherLanguages"] ?? '',
        examBased: json["examBased"] ?? '',
        portfolioBased: json["portfolioBased"] ?? '',
        bacNeeded: json["bacNeeded"] ?? '',
        averageGpaEntry: json["averageGpaEntry"] ?? '',
        averageApplicantsNumber: json["averageApplicantsNumber"] ?? '',
        admissionDates: json["admissionDates"] ?? '',
        admissionsDescription: json["admissionsDescription"] ?? '',
        admissionsPageUrl: json["admissionsPageUrl"] ?? '',
        admissionsMapsLocationUrl: json["admissionsMapsLocationUrl"] ?? '',
        safetyRate: json["safetyRate"] ?? '',
        averageStudentsNumber: json["averageStudentsNumber"] ?? '',
        costPerYear: json["costPerYear"] ?? '',
        campusDescription: json["campusDescription"] ?? '',
        campusPageUrl: json["campusPageUrl"] ?? '',
        campusMapsLocationUrl: json["campusMapsLocationUrl"] ?? '',
        numbeoCrimeUrl: json["numbeoCrimeUrl"] ?? '',
        numbeoSafetyUrl: json["numbeoSafetyUrl"] ?? '',
      );
}