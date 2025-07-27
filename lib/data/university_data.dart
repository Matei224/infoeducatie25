class UniversityData {
  final Academics academics;
  final Costs costs;
  final Life life;
  final Admissions admissions;
  final Campus campus;

  UniversityData({
    required this.academics,
    required this.costs,
    required this.life,
    required this.admissions,
    required this.campus,
  });
}

class Academics {
  final String graduationRate;
  final String employabilityRate;
  final String retentionRate;
  final String rank;
  final String extracurricularClubs;
  final String undergraduateProgrammesCount;
  final String undergraduateProgrammes;
  final String description;
  final String homePageUrl;
  final String mapsLocationUrl;

  Academics({
    required this.graduationRate,
    required this.employabilityRate,
    required this.retentionRate,
    required this.rank,
    required this.extracurricularClubs,
    required this.undergraduateProgrammesCount,
    required this.undergraduateProgrammes,
    required this.description,
    required this.homePageUrl,
    required this.mapsLocationUrl,
  });
}

class Costs {
  final String averageCostPerYear;
  final String studentsReceivingFinancialAidPercentage;
  final String financialAidApplicationDate;

  Costs({
    required this.averageCostPerYear,
    required this.studentsReceivingFinancialAidPercentage,
    required this.financialAidApplicationDate,
  });
}

class Life {
  final String housingFoundRate;
  final String housingPricePerYear;
  final String taxesCostPerYear;
  final String suppliesCostPerYear;
  final String description;
  final String costsPageUrl;
  final String mapsLocationUrl;
  final String numbeoPropertyPricesUrl;
  final String numbeoGoodsAndServicesPricesUrl;
  final String numbeoFoodPricesUrl;

  Life({
    required this.housingFoundRate,
    required this.housingPricePerYear,
    required this.taxesCostPerYear,
    required this.suppliesCostPerYear,
    required this.description,
    required this.costsPageUrl,
    required this.mapsLocationUrl,
    required this.numbeoPropertyPricesUrl,
    required this.numbeoGoodsAndServicesPricesUrl,
    required this.numbeoFoodPricesUrl,
  });
}

class Admissions {
  final String acceptanceRate;
  final String englishRequirements;
  final String otherLanguages;
  final String examBased;
  final String portfolioBased;
  final String bacNeeded;
  final String averageGpaEntry;
  final String averageApplicantsNumber;
  final String admissionDates;
  final String description;
  final String admissionsPageUrl;
  final String mapsLocationUrl;

  Admissions({
    required this.acceptanceRate,
    required this.englishRequirements,
    required this.otherLanguages,
    required this.examBased,
    required this.portfolioBased,
    required this.bacNeeded,
    required this.averageGpaEntry,
    required this.averageApplicantsNumber,
    required this.admissionDates,
    required this.description,
    required this.admissionsPageUrl,
    required this.mapsLocationUrl,
  });
}

class Campus {
  final String safetyRate;
  final String averageStudentsNumber;
  final String costPerYear;
  final String description;
  final String campusPageUrl;
  final String mapsLocationUrl;
  final String numbeoCrimeUrl;
  final String numbeoSafetyUrl;

  Campus({
    required this.safetyRate,
    required this.averageStudentsNumber,
    required this.costPerYear,
    required this.description,
    required this.campusPageUrl,
    required this.mapsLocationUrl,
    required this.numbeoCrimeUrl,
    required this.numbeoSafetyUrl,
  });
}
Map<String, Map<String, String>> parseData1(String input) {
  final data = <String, Map<String, String>>{};
  final lines = input.split('\n');
  String? currentCategory;

  for (var line in lines) {
    line = line.trim();
    if (line.startsWith('**') && line.endsWith('**')) {
      final categoryName = line.substring(2, line.length - 2).trim();
      if ([
        'Academics category',
        'Costs category',
        'Life category',
        'Admissions category',
        'Campus category'
      ].contains(categoryName)) {
        currentCategory = categoryName;
        data[currentCategory] = <String, String>{};
      } else {
        currentCategory = null;
      }
    } else if (line.startsWith('-') && currentCategory != null) {
      final parts = line.substring(1).split(':');
      if (parts.length >= 2) {
        final label = parts[0].trim();
        final value = parts.sublist(1).join(':').trim();
        data[currentCategory]![label] = value;
      }
    }
  }
  return data;
}


Map<String, Map<String, String>> parseData2(String input) {
  final data = <String, Map<String, String>>{};
  final lines = input.split('\n');
  String? currentCategory;

  for (var line in lines) {
    line = line.trim();
    int start = line.indexOf('**');
    if (start != -1) {
      int end = line.indexOf('**', start + 2);
      if (end != -1) {
        final categoryName = line.substring(start + 2, end).trim();
        if ([
          'Academics category',
          'Costs category',
          'Life category',
          'Admissions category',
          'Campus category'
        ].contains(categoryName)) {
          currentCategory = categoryName;
          data[currentCategory] = <String, String>{};
        } else {
          currentCategory = null;
        }
      }
    } else if (line.startsWith('-') && currentCategory != null) {
      final parts = line.substring(1).split(':');
      if (parts.length >= 2) {
        var label = parts[0].trim();
       
        final value = parts.sublist(1).join(':').trim();
        data[currentCategory]![label] = value;
      }
    }
  }
  return data;
}

Academics createAcademics(Map<String, String> academicsData) {
  return Academics(
    graduationRate: academicsData["Graduation rate"] ?? '',
    employabilityRate: academicsData["Employabillity rate"] ?? '',
    retentionRate: academicsData["Retention Rate"] ?? '',
    rank: academicsData["Rank"] ?? '',
    extracurricularClubs: academicsData["Extracurricular Clubs enumerate"] ?? '',
    undergraduateProgrammesCount: academicsData["Undergraduate programmes available number and list"] ?? '',
    undergraduateProgrammes: academicsData["Undergraduate programmes available number and list"] ?? '',
    description: academicsData["Description of Academics"] ?? '',
    homePageUrl: academicsData["Home page university website"] ?? '',
    mapsLocationUrl: academicsData["maps location link"] ?? '',
  );
}

Costs createCosts(Map<String, String> costsData) {
  return Costs(
    averageCostPerYear: costsData["Average cost per Year"] ?? '',
    studentsReceivingFinancialAidPercentage: costsData["Students Receiving Financial Aid percentage"] ?? '',
    financialAidApplicationDate: costsData["Opened Financial Aid Application date"] ?? '',
  );
}

Life createLife(Map<String,String> data) {
  print(data["Link to numbeo website for that city of university with prices for property"]?? 'not fpund');
  return Life(
    housingFoundRate: data["Housing Found Rate by students"] ?? '',
    housingPricePerYear: data["Housing price per year"] ?? '',
    taxesCostPerYear: data["Taxes cost per year"] ?? '',
    suppliesCostPerYear: data["Supplies cost per year"] ?? '',
    description: data["Description of life in the city of university"] ?? '',
    costsPageUrl: data["Costs page university website"] ?? '',
    mapsLocationUrl: data["maps location link"] ?? '',
    numbeoPropertyPricesUrl: data["Link to numbeo website for that city of university with prices for property"] ?? '',
    numbeoGoodsAndServicesPricesUrl: data["Link to numbeo website for that city of university with prices for good and services"] ?? '',
    numbeoFoodPricesUrl: data["Link to numbeo website for that city of university with prices for and food prices"] ?? '',
  );
}

Admissions createAdmissions(Map<String, String> admissionsData) {
  return Admissions(
    acceptanceRate: admissionsData["Acceptance Rate"] ?? '',
    englishRequirements: admissionsData["English Requirements"] ?? '',
    otherLanguages: admissionsData["Other languages"] ?? '',
    examBased: admissionsData["Exam based"] ?? '',
    portfolioBased: admissionsData["Portfolio based"] ?? '',
    bacNeeded: admissionsData["Which BAC is needed?"] ?? '',
    averageGpaEntry: admissionsData["Average GPA entry"] ?? '',
    averageApplicantsNumber: admissionsData["Average applicants number"] ?? '',
    admissionDates: admissionsData["Admission dates for next year"] ?? '',
    description: admissionsData["Description of admissions"] ?? '',
    admissionsPageUrl: admissionsData["Admissions page university"] ?? '',
    mapsLocationUrl: admissionsData["maps location link"] ?? '',
  );
}

Campus createCampus(Map<String, String> campusData) {
  return Campus(
    safetyRate: campusData["Safety Rate"] ?? '',
    averageStudentsNumber: campusData["Average students in campus number"] ?? '',
    costPerYear: campusData["Cost per year of campus"] ?? '',
    description: campusData["Description"] ?? '',
    campusPageUrl: campusData["Campus page university link"] ?? '',
    mapsLocationUrl: campusData["maps location link"] ?? '',
    numbeoCrimeUrl: campusData["Link to numbeo website for that city of university with crime"] ?? '',
    numbeoSafetyUrl: campusData["Link to numbeo website for that city of university with safety"] ?? '',
  );
}
UniversityData parseUniversityData(String input) {
  final data = parseData1(input);
  final academics = createAcademics(data["Academics category"]!);
  final costs = createCosts(data["Costs category"]!);
  final life = createLife(data["Life category"]!);
  final admissions = createAdmissions(data["Admissions category"]!);
  final campus = createCampus(data["Campus category"]!);

  return UniversityData(
    academics: academics,
    costs: costs,
    life: life,
    admissions: admissions,
    campus: campus,
  );
}

