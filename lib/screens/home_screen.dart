import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studee_app/widgets/model/lineModel.dart';
import 'package:studee_app/widgets/model/profileChangeUniv.dart';
import 'package:studee_app/data/university/univeristy_full.dart';
import 'package:studee_app/widgets/model/universityWidget.dart';
import 'package:studee_app/screens/favorites_screen.dart';

class HomePage extends StatefulWidget {
  final Future<Database> database;

  const HomePage({Key? key, required this.database}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>>? carouselsData;

  @override
  void initState() {
    super.initState();
    _loadCarouselsData();
  }










Future<List<Map<String, dynamic>>> _loadSearchHistoryCarousels(
  List<ActualUniveristy> allUnivs,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> searchHistory = prefs.getStringList('searchHistory') ?? [];
  searchHistory = searchHistory.length > 5
      ? searchHistory.sublist(searchHistory.length - 5)
      : searchHistory;

  List<Map<String, dynamic>> searchCarousels = [];
  ActualUniveristy? target;
  for (String name in searchHistory) {
    var matchingUnivs = allUnivs.where((univ) => univ.name.contains(name)).toList();
    if (matchingUnivs.isNotEmpty) {
      target = matchingUnivs.first;
    }
  }
  if (target != null) {
    List<ActualUniveristy> similarUnivs = _getMostSimilarUniversities(
      target,
      allUnivs,
    );
    searchCarousels.add({
      'university': target,
      'similarUniversities': similarUnivs,
      'type': 'search',
    });
  }

  return searchCarousels;
}

  Future<List<Map<String, dynamic>>> _loadProfileCarousels(
    List<ActualUniveristy> allUnivs,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    List<Map<String, dynamic>> profileCarousels = [];

    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      double? profileGpa = double.tryParse(data['gpa'] ?? '0.0');
      String? subject = data['subject'];
      print(subject);
      List<dynamic>? topUnivs = data['topUnivs'] as List<dynamic>?;

      if (profileGpa != null) {
        List<ActualUniveristy> gpaMatches =
            allUnivs.where((univ) {
              double? univGpa = double.tryParse(univ.averageGpaEntry ?? '0.0');
              return univGpa != null && profileGpa <= univGpa;
            }).toList();
        gpaMatches.sort((a, b) {
          double? gpaA = double.tryParse(a.averageGpaEntry ?? '0.0');
          double? gpaB = double.tryParse(b.averageGpaEntry ?? '0.0');
          return (gpaB ?? 0.0).compareTo(gpaA ?? 0.0);
        });
        List<ActualUniveristy> topGpaUnivs = gpaMatches.take(6).toList();
        if (topGpaUnivs.isNotEmpty) {
          profileCarousels.add({
            'university': ActualUniveristy(
              name: 'Based on GPA: $profileGpa',
              averageGpaEntry: profileGpa.toString(),
              country: '',
              city: '',
              undergraduateProgrammes: '',
              averageCostPerYear: '',
              degree: '',
              language: '',
              alphaTwoCode: '',
              abreviation: '',
              urlImage: '',
              programme: '',
              webPages: [],
              graduationRate: '',
              employabilityRate: '',
              retentionRate: '',
              rank: '',
              extracurricularClubs: '',
              academicsDescription: '',
              homePageUrl: '',
              academicsMapsLocationUrl: '',
              studentsReceivingFinancialAidPercentage: '',
              financialAidApplicationDate: '',
              housingFoundRate: '',
              housingPricePerYear: '',
              taxesCostPerYear: '',
              suppliesCostPerYear: '',
              lifeDescription: '',
              costsPageUrl: '',
              lifeMapsLocationUrl: '',
              numbeoPropertyPricesUrl: '',
              numbeoGoodsAndServicesPricesUrl: '',
              numbeoFoodPricesUrl: '',
              acceptanceRate: '',
              englishRequirements: '',
              otherLanguages: '',
              examBased: '',
              portfolioBased: '',
              bacNeeded: '',
              averageApplicantsNumber: '',
              admissionDates: '',
              admissionsDescription: '',
              admissionsPageUrl: '',
              admissionsMapsLocationUrl: '',
              safetyRate: '',
              averageStudentsNumber: '',
              costPerYear: '',
              campusDescription: '',
              campusPageUrl: '',
              campusMapsLocationUrl: '',
              numbeoCrimeUrl: '',
              numbeoSafetyUrl: '',
            ), 
            'similarUniversities': topGpaUnivs,
            'type': 'profile_gpa',
          });
        }
      }

      if (subject != null && subject.isNotEmpty) {
        List<ActualUniveristy> subjectMatches =
            allUnivs.where((univ) {
              Set<String> univPrograms =
                  univ.undergraduateProgrammes.split(', ').toSet();
              return univPrograms.contains(subject);
            }).toList();
        List<ActualUniveristy> topSubjectUnivs =
            subjectMatches.take(6).toList();
        if (topSubjectUnivs.isNotEmpty) {
          profileCarousels.add({
            'university': ActualUniveristy(
              name: 'Based on Subject: $subject',
              averageGpaEntry: '',
              country: '',
              city: '',
              undergraduateProgrammes: subject,
              averageCostPerYear: '',
              degree: '',
              language: '',
              alphaTwoCode: '',
              abreviation: '',
              urlImage: '',
              programme: '',
              webPages: [],
              graduationRate: '',
              employabilityRate: '',
              retentionRate: '',
              rank: '',
              extracurricularClubs: '',
              academicsDescription: '',
              homePageUrl: '',
              academicsMapsLocationUrl: '',
              studentsReceivingFinancialAidPercentage: '',
              financialAidApplicationDate: '',
              housingFoundRate: '',
              housingPricePerYear: '',
              taxesCostPerYear: '',
              suppliesCostPerYear: '',
              lifeDescription: '',
              costsPageUrl: '',
              lifeMapsLocationUrl: '',
              numbeoPropertyPricesUrl: '',
              numbeoGoodsAndServicesPricesUrl: '',
              numbeoFoodPricesUrl: '',
              acceptanceRate: '',
              englishRequirements: '',
              otherLanguages: '',
              examBased: '',
              portfolioBased: '',
              bacNeeded: '',
              averageApplicantsNumber: '',
              admissionDates: '',
              admissionsDescription: '',
              admissionsPageUrl: '',
              admissionsMapsLocationUrl: '',
              safetyRate: '',
              averageStudentsNumber: '',
              costPerYear: '',
              campusDescription: '',
              campusPageUrl: '',
              campusMapsLocationUrl: '',
              numbeoCrimeUrl: '',
              numbeoSafetyUrl: '',
            ),
            'similarUniversities': topSubjectUnivs,
            'type': 'profile_subject',
          });
        }
      }

      if (topUnivs != null && topUnivs.length >= 3) {
        for (String univName in topUnivs.take(3)) {
          var matchingUnivs =
              allUnivs.where((univ) => univ.name == univName).toList();
          if (matchingUnivs.isNotEmpty) {
            ActualUniveristy target = matchingUnivs.first;
            List<ActualUniveristy> similarUnivs = _getSimilarForFavorite(
              target,
              allUnivs,
            );
            profileCarousels.add({
              'university': target,
              'similarUniversities': similarUnivs,
              'type': 'profile_topuniv',
            });
          }
        }
      }
    }

    return profileCarousels;
  }

  Future<void> _loadCarouselsData() async {
    final db = await widget.database;
    final maps = await db.query('universities');
    List<ActualUniveristy> allUnivs =
        maps.map((map) => ActualUniveristy.fromMap(map)).toList();

    List<Future<List<Map<String, dynamic>>>> futures = [
      _loadProfileCarousels(allUnivs),
      _loadFavoritesCarousels(allUnivs),
      _loadSearchHistoryCarousels(allUnivs) 
    ];

    List<List<Map<String, dynamic>>> results = await Future.wait(futures);

    List<Map<String, dynamic>> tempCarousels = [...results[0],...results[1],...results[2]];

    setState(() {
      carouselsData = tempCarousels;
    });
  }

  Future<List<Map<String, dynamic>>> _loadFavoritesCarousels(
    List<ActualUniveristy> allUnivs,
  ) async {
    List<ActualUniveristy> favorites = await getFavoriteUniversitiesList();

    List<Map<String, dynamic>> favoriteCarousels = [];
    for (ActualUniveristy favorite in favorites) {
      List<ActualUniveristy> similarUnivs = _getSimilarForFavorite(
        favorite,
        allUnivs,
      );
      favoriteCarousels.add({
        'university': favorite,
        'similarUniversities': similarUnivs,
        'type': 'favorite',
      });
    }
    return favoriteCarousels;
  }

  @override
  int _calculateSimilarity(ActualUniveristy univ1, ActualUniveristy univ2) {
    int score = 0;
    if (univ1.city == univ2.city) score++;
    if (univ1.country == univ2.country) score++;
    if (univ1.degree == univ2.degree) score++;
    if (univ1.programme == univ2.programme) score++;
    if (univ1.language == univ2.language) score++;
    if (univ1.alphaTwoCode == univ2.alphaTwoCode) score++;
    return score;
  }

  List<ActualUniveristy> _getMostSimilarUniversities(
  ActualUniveristy target,
  List<ActualUniveristy> allUnivs,
) {
  List<ActualUniveristy> others =
      allUnivs.where((univ) => univ.name != target.name).toList();
  others.sort(
    (a, b) => _calculateSimilarity(
      target,
      b,
    ).compareTo(_calculateSimilarity(target, a)),
  );
  return others.take(6).toList();
}

  int _calculateFavoriteSimilarity(
    ActualUniveristy fav,
    ActualUniveristy other,
  ) {
    int score = 0;

    if (fav.country == other.country) {
      score += 1;
    }

    Set<String> favPrograms = fav.undergraduateProgrammes.split(', ').toSet();
    Set<String> otherPrograms =
        other.undergraduateProgrammes.split(', ').toSet();
    int commonPrograms = favPrograms.intersection(otherPrograms).length;
    score += commonPrograms;

    Set<String> favBudgetWords =
        fav.averageCostPerYear.toLowerCase().split(' ').toSet();
    Set<String> otherBudgetWords =
        other.averageCostPerYear.toLowerCase().split(' ').toSet();
    int commonBudgetWords =
        favBudgetWords.intersection(otherBudgetWords).length;
    score += commonBudgetWords;

    return score;
  }

  List<ActualUniveristy> _getSimilarForFavorite(
    ActualUniveristy favorite,
    List<ActualUniveristy> allUnivs,
  ) {
    List<ActualUniveristy> others =
        allUnivs.where((univ) => univ.name != favorite.name).toList();
    others.sort(
      (a, b) => _calculateFavoriteSimilarity(
        favorite,
        b,
      ).compareTo(_calculateFavoriteSimilarity(favorite, a)),
    );
    return others.take(6).toList();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (carouselsData == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: carouselsData!.length,
        itemBuilder: (context, index) {
          var data = carouselsData![index];
          ActualUniveristy university = data['university'];
          List<ActualUniveristy> similarUnivs = data['similarUniversities'];
          String type = data['type'];
          final textSpan1 =  TextSpan(
                            text:
                                type == 'search'
                                    ? "Searched"
                                    : type == 'favorite'
                                    ? "Favorite university"
                                    : type == 'profile_gpa'
                                    ? "GPA"
                                    : type == 'profile_subject'
                                    ? "Favorite subject"
                                    : type == 'profile_topuniv'
                                    ? "Top university"
                                    : "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
          final textSpan2 =    TextSpan(
                            text:
                                type == 'search'
                                    ? " (${generateAbbreviation(university.name)})"
                                    : type == 'favorite'
                                    ? " (${university.name})"
                                    : type == 'profile_gpa'
                                    ? " (${university.averageGpaEntry})"
                                    : type == 'profile_subject'
                                    ? " (${university.undergraduateProgrammes})"
                                    : type == 'profile_topuniv'
                                    ? " (${generateAbbreviation(university.name)})"
                                    : "",
                            style: const TextStyle(fontWeight: FontWeight.w300),

                          );
                          final tp1 = TextPainter(text: textSpan1, textDirection: TextDirection.ltr);
                          final tp2 = TextPainter(text: textSpan2, textDirection: TextDirection.ltr);
                          tp1.layout();tp2.layout();
                          final width = tp1.width+ tp2.width;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(19.0),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 81, 0),
                        ),
                        children: [
                         textSpan1,
                        textSpan2
                        ],
                      ),
                    ),
                    SizedBox(width: 4),
                    LineModel(textWidth: width,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  height:
                      150, 
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: similarUnivs.length,
                    itemBuilder: (context, idx) {
                      ActualUniveristy similarUniv = similarUnivs[idx];
                      return Container(
                        width:
                            size.width * 0.46, 
                        margin: EdgeInsets.symmetric(
                          horizontal: 6,
                        ), 
                        child: UniversityWidget(
                          data: similarUniv,
                          isCarouselItem: true,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}

String getCurrentUserId() {
  return 'current_user_id';
}
