import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studee_app/data/university.dart';
import 'package:studee_app/data/university/univeristy_full.dart';
import 'package:studee_app/widgets/model/universityInfoPage.dart';

class FavoritesWidget extends StatefulWidget {
  FavoritesWidget({super.key, required this.favorite});
  ActualUniveristy favorite;
  @override
  State<FavoritesWidget> createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  bool isBookMarked = true;
  Color color = Colors.amber;
  void toggleFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    final favoriteUniv = widget.favorite.toMap();
    
      final docRef = FirebaseFirestore.instance.collection('favorites').doc(user!.uid);
final doc = await docRef.get();
if (doc.exists) {
  List<dynamic> universities = List.from(doc.data()?['universities'] ?? []);
  if (universities.isNotEmpty) {
    universities.removeAt(0);
    await docRef.update({'universities': universities});
  }
}
setState(() {
  isBookMarked = false;
  color = Colors.black;
});
     
    
  }

  void navigateToUniversityInfo(BuildContext context, ActualUniveristy university) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                UniversityDetailScreen(university: university),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.25,
      height: size.height * 0.35,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // purple offset background
          Positioned(
            top: 8,
            left: 8,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 115, 0, 255),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // main white card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.black, width: 1.3),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // top image
                GestureDetector(
                  onTap:
                      () => navigateToUniversityInfo(context, widget.favorite),

                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: AspectRatio(
                      aspectRatio: 5 / 3,
                      child: Image.network(
                        widget.favorite.urlImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // text + icon row
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color.fromARGB(255, 255, 251, 238),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // title + subtitle
                          Text(
                            widget.favorite.name,
                            style: GoogleFonts.poppins(
                              color: Color(0xFFDD4814),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                             
                                    Text(
                                      widget.favorite.country,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(
                                      255,
                                      255,
                                      251,
                                      238,
                                    ), // Orange background for text
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black, // Orange border
                                      width: 1.5,
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: toggleFavorites,
                                    child: Icon(
                                      Icons.bookmark_border,
                                      color: color,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // bookmark icon
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
