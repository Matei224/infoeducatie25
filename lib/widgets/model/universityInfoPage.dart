import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/model/tabs/academicsTab.dart';
import 'package:studee_app/model/tabs/admissionsTab.dart';
import 'package:studee_app/model/tabs/campusTab.dart';
import 'package:studee_app/model/tabs/costsTab.dart';
import 'package:studee_app/model/university.dart';
import 'package:studee_app/model/university/univeristy_full.dart'; 

class UniversityDetailScreen extends StatefulWidget {
  final ActualUniveristy university;

  const UniversityDetailScreen({super.key, required this.university});

  @override
  State<UniversityDetailScreen> createState() => _UniversityDetailScreenState();
}

class _UniversityDetailScreenState extends State<UniversityDetailScreen> {
  bool isBookMarked = false;

  void toggleBookmark() {
    setState(() {
      isBookMarked = !isBookMarked;
    });
  }

  Color color = Colors.black;
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Added to favorites!')));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Removed from favorites!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 255, 251, 238)),

        child: Center(
          child: Column(
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
                padding: const EdgeInsets.all(25),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, size: 20),
                    ),
                    Stack(
                      children: [
                        widget.university.urlImage != null &&
                                widget.university.urlImage != '' &&
                                widget.university.urlImage != ' '
                            ? ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),

                              child: Container(
                                height: 230,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      widget.university.urlImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                            : ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),

                              child: Image.asset(
                                'assets/images/nophoto.jpg',
                                fit: BoxFit.cover,
                                height: 230,
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
                                  widget.university.name == null
                                      ? ' '
                                      : widget.university.name!,

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
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(
                                255,
                                255,
                                251,
                                238,
                              ), 
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black, 
                                width: 1.5,
                              ),
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
                    DefaultTabController(
                      length: 4,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: [
                              Tab(
                                child: Text(
                                  'Academic',
                                  style: GoogleFonts.raleway(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 115, 0, 255),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Costs',
                                  style: GoogleFonts.raleway(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 200, 255, 0),                                        
                                fontWeight: FontWeight.bold

                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Admission',
                                  style: GoogleFonts.raleway(
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 255, 81, 0),                                    
                                    fontWeight: FontWeight.bold

                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Campus',
                                  style: GoogleFonts.raleway(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 255, 132, 177),                                   
                                    fontWeight: FontWeight.bold

                                  ),
                                ),
                              ),
                            ],
                            labelColor:
                                Colors
                                    .black, 
                            unselectedLabelStyle: GoogleFonts.raleway(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            indicatorWeight: 4.0,
                            unselectedLabelColor:
                                Colors
                                    .grey, 
                          ),
                          SizedBox(
                            height: size.width*0.8, 
                            child: TabBarView(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
