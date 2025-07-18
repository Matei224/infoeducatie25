import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:studee_app/model/university.dart";
import "package:studee_app/model/universityInfoPage.dart";

class UniversityWidget extends StatefulWidget {
  const UniversityWidget({super.key, required this.data});
  final University data;

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

  void navigateToUniversityInfo(BuildContext context, University university) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: GestureDetector(
              onTap: () => navigateToUniversityInfo(context, widget.data),

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
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
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1590579491624-f98f36d4c763?q=80&w=1443&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ), // Background image
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black, // Orange border
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Text overlay in bottom left
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
                                          color: Color.fromARGB(
                                            255,
                                            255,
                                            251,
                                            238,
                                          ), // Orange background for text
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color:
                                                Colors.black, // Orange border
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              widget.data.name,
                                              style: GoogleFonts.raleway(
                                                textStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    115,
                                                    0,
                                                    255,
                                                  ),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              "${widget.data.city}, ${widget.data.country}",
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
                            // Bookmark icon in bottom right
                            Positioned(
                              bottom: 24,
                              right: 16,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                    255,
                                    255,
                                    251,
                                    238,
                                  ), // Orange background for text
                                  borderRadius: BorderRadius.circular(14),
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
                                    size: 24,
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
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
