import "package:cached_network_image/cached_network_image.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:studee_app/data/university.dart";
import "package:studee_app/data/university/univeristy_full.dart";
import "package:studee_app/widgets/model/universityInfoPage.dart";

class UniversityWidget extends StatefulWidget {
  const UniversityWidget({super.key, required this.data, this.isCarouselItem = false});
  final ActualUniveristy data;
  final bool isCarouselItem;

  @override
  State<UniversityWidget> createState() => _UniversityWidgetState();
}

class _UniversityWidgetState extends State<UniversityWidget> {
  bool isBookMarked = false;
  Color color = Colors.black;

  void toggleFavorites() async {
    final user = FirebaseAuth.instance.currentUser;
    final favoriteUniv = widget.data.toMap();
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Added to favorites!')));
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Removed from favorites!')));
    }
  }

  void navigateToUniversityInfo(BuildContext context, ActualUniveristy university) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            UniversityDetailScreen(university: university),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double padding = widget.isCarouselItem ? 2.0 : 37.0; // Reduced padding for carousel
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity, // Will be constrained by parent Container
            height: 150,
            child: GestureDetector(
              onTap: () => navigateToUniversityInfo(context, widget.data),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 81, 0),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    Positioned.fill(
                      bottom: 5,
                      left: -5,
                      right: 5,
                      top: -5,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.data.urlImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 24,
                              left: 16,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 81, 0),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 255, 251, 238),
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(color: Colors.black, width: 1.5),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.data.abreviation,
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: Color.fromARGB(255, 115, 0, 255),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              widget.data.country,
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                             widget.isCarouselItem == false ?
                            Positioned(
                              bottom: 24,
                              right: 16,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 251, 238),
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
                            )
                            :
                               Positioned(
                              bottom: 90,
                              right: 5,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 251, 238),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: Colors.black, width: 1.5),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!widget.isCarouselItem) const SizedBox(height: 25), // Omit in carousel
        ],
      ),
    );
  }
}