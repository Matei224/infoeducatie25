import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/widgets/animationWidget.dart';
import 'package:studee_app/widgets/model/tabs/academicsTab.dart';
import 'package:studee_app/widgets/model/tabs/admissionsTab.dart';
import 'package:studee_app/widgets/model/tabs/campusTab.dart';
import 'package:studee_app/widgets/model/tabs/costsTab.dart';
import 'package:studee_app/data/university.dart';
import 'package:studee_app/data/university/univeristy_full.dart';
import 'dart:async';

class SelectedText extends StatelessWidget {
  final String text;
  final int index;
  final Color selectedColor;
  final TabController tabController;

  const SelectedText({
    required this.text,
    required this.index,
    required this.selectedColor,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = tabController.index == index;
    return Text(
      text,
      style: GoogleFonts.raleway(
        fontSize: isSelected ? 12 : 10,
        color: isSelected ? selectedColor : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class UniversityDetailScreen extends StatefulWidget {
  final ActualUniveristy university;

  const UniversityDetailScreen({super.key, required this.university});

  @override
  State<UniversityDetailScreen> createState() => _UniversityDetailScreenState();
}

class _UniversityDetailScreenState extends State<UniversityDetailScreen> with TickerProviderStateMixin {
  bool isBookMarked = false;
  Color color = Colors.black;
  bool showAnimation = false;
  String? currentAnimationFile;
  late TabController tabController;
  Timer? animationTimer;
  final List<Color> tabColors = [
    Color.fromARGB(255, 115, 0, 255), 
    Color.fromARGB(255, 200, 255, 0),  
    Color.fromARGB(255, 255, 81, 0),   
    Color.fromARGB(255, 255, 132, 177), 
  ];

  Color currentIndicatorColor = Color.fromARGB(255, 115, 0, 255);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(_handleTabChange);
    _handleTabChange();
  }

  void _handleTabChange() {
    if (tabController.index == 0){
      currentAnimationFile = 'assets/animations/studee_nova.riv';
  } else if (tabController.index == 1) {
          currentAnimationFile = 'assets/animations/studee_toki.riv';

  }  else if (tabController.index == 2) {
          currentAnimationFile = 'assets/animations/studee_juno.riv';

  } else {
              currentAnimationFile = 'assets/animations/studee_raya.riv';

  }

    setState(() {
      showAnimation = true;
      currentIndicatorColor = tabColors[tabController.index];
    });

    animationTimer?.cancel();

    animationTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showAnimation = false;
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    animationTimer?.cancel();
    super.dispose();
  }

  void toggleFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    final favoriteUniv = widget.university.toMap();
    if (!isBookMarked) {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .set({
            'universities': FieldValue.arrayUnion([favoriteUniv]),
          }, SetOptions(merge: true));
      setState(() {
        isBookMarked = true;
        color = Colors.amber;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to favorites!')));
    } else {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(user!.uid)
          .update({
            'universities': FieldValue.arrayRemove([favoriteUniv]),
          });
      setState(() {
        isBookMarked = false;
        color = Colors.black;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Removed from favorites!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 238),
      body: Stack(
        children: [
          Column(
            children: [
              SafeArea(
                top: true,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: size.width * 0.28,
                  height: size.height * 0.035,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: size.height*0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, size: 20),
                    ),
                    Stack(
                      children: [
                        widget.university.urlImage != null &&
                                widget.university.urlImage != '' &&
                                widget.university.urlImage != ' '
                            ? ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                child: Container(
                                  height: size.width*0.5,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(widget.university.urlImage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                child: Image.asset(
                                  'assets/images/nophoto.jpg',
                                  fit: BoxFit.cover,
                                  height: size.width*0.5,
                                  width: double.infinity,
                                ),
                              ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(widget.university.abreviation),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.university.name ?? ' ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.university.country,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 251, 238),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.black, width: 1.5),
                            ),
                            child: GestureDetector(
                              onTap: toggleFavorites,
                              child: Icon(
                                Icons.bookmark_border,
                                color: color,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TabBar(
                          indicatorColor: currentIndicatorColor,
                          controller: tabController,
                          tabs: [
                            Tab(
                              child: SelectedText(
                                text: 'Academic',
                                index: 0,
                                selectedColor: tabColors[0],
                                tabController: tabController,
                              ),
                            ),
                            Tab(
                              child: SelectedText(
                                text: 'Costs',
                                index: 1,
                                selectedColor: tabColors[1],
                                tabController: tabController,
                              ),
                            ),
                            Tab(
                              child: SelectedText(
                                text: 'Admision',
                                index: 2,
                                selectedColor: tabColors[2],
                                tabController: tabController,
                              ),
                            ),
                            Tab(
                              child: SelectedText(
                                text: 'Campus',
                                index: 3,
                                selectedColor: tabColors[3],
                                tabController: tabController,
                              ),
                            ),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelStyle: GoogleFonts.raleway(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          indicatorWeight: 4.0,
                          unselectedLabelColor: Colors.grey,
                        ),
                        SizedBox(
                          height: size.width * 0.9,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              AcademicsTab(university: widget.university),
                              CostsTab(university: widget.university),
                              AdmissionsTab(university: widget.university),
                              CampusTab(university: widget.university),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showAnimation && currentAnimationFile != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.2,
                child: AnimationWidge(text: currentAnimationFile!),
              ),
            ),
        ],
      ),
    );
  }
}



