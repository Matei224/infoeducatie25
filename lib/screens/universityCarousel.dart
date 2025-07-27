// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:studee_app/model/university.dart';
// import 'package:studee_app/model/university/univeristy_full.dart';
// import 'package:studee_app/model/universityInfoPage.dart';

// class UniversityCarousel extends StatefulWidget {
//   final List<University> universities;
//   const UniversityCarousel({super.key, required this.universities});

//   @override
//   _UniversityCarouselState createState() => _UniversityCarouselState();
// }

// class _UniversityCarouselState extends State<UniversityCarousel> {
//   late final List<University> ukUniversities;
//   final PageController _controller = PageController(viewportFraction: 0.8);

//   @override
//   void initState() {
//     super.initState();
//     // Filter only UK universities
//     ukUniversities =
//         widget.universities.where((u) => u.country == 'Germany').toList();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       child: PageView.builder(
//         controller: _controller,
//         itemCount: ukUniversities.length,
//         itemBuilder: (context, index) {
//           final uni = ukUniversities[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: UniversityWidget(data: uni),
//           );
//         },
//       ),
//     );
//   }
// }

// class UniversityWidget extends StatefulWidget {
//   const UniversityWidget({super.key, required this.data});
//   final ActualUniveristy data;

//   @override
//   State<UniversityWidget> createState() => _UniversityWidgetState();
// }

// class _UniversityWidgetState extends State<UniversityWidget> {
//   bool isBookMarked = false;

//   void toggleFavorites() async {
//     final user = FirebaseAuth.instance.currentUser;
//     final favoriteUniv = widget.data.toMap();
//     if (!isBookMarked) {
//       await FirebaseFirestore.instance
//           .collection('favorites')
//           .doc(user!.uid)
//           .set({
//             'universities': FieldValue.arrayUnion([favoriteUniv]),
//           }, SetOptions(merge: true));
//       setState(() => isBookMarked = true);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Added to favorites!')));
//     } else {
//       await FirebaseFirestore.instance
//           .collection('favorites')
//           .doc(user!.uid)
//           .update({
//             'universities': FieldValue.arrayRemove([favoriteUniv]),
//           });
//       setState(() => isBookMarked = false);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Removed from favorites!')));
//     }
//   }

//   void navigateToUniversityInfo(BuildContext context, University university) {
//     Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder:
//             (context, animation, secondaryAnimation) =>
//                 UniversityDetailScreen(university: university),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => navigateToUniversityInfo(context, widget.data),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 4,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             image: DecorationImage(
//               image: NetworkImage(
//                 'https://images.unsplash.com/photo-1590579491624-f98f36d4c763?q=80&w=1443&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Positioned(
//                 bottom: 16,
//                 left: 16,
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white70,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.data.name,
//                         style: GoogleFonts.raleway(
//                           textStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "${widget.data.city}, ${widget.data.country}",
//                         style: GoogleFonts.raleway(
//                           textStyle: TextStyle(
//                             color: Colors.black54,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: GestureDetector(
//                   onTap: toggleFavorites,
//                   child: Icon(
//                     isBookMarked ? Icons.bookmark : Icons.bookmark_border,
//                     color: isBookMarked ? Colors.amber : Colors.white,
//                     size: 28,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Usage Example in a Scaffold:
// //
// // Scaffold(
// //   body: Padding(
// //     padding: const EdgeInsets.symmetric(vertical: 32.0),
// //     child: UniversityCarousel(universities: uni), // uni contains all universities
// //   ),
// // );
