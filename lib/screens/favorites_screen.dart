import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studee_app/widgets/model/favoritesWidget.dart';
import 'package:studee_app/data/university.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:studee_app/data/university/univeristy_full.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key, required this.favorites});
  List<ActualUniveristy> favorites;
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Stream<List<ActualUniveristy>> getFavoriteUniversitiesStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }
    final uid = user.uid;
    return FirebaseFirestore.instance
        .collection('favorites')
        .doc(uid)
        .snapshots()
        .map((doc) {
          if (doc.exists) {
            final data = doc.data();
            if (data != null &&
                data.containsKey('universities') &&
                data['universities'] is List) {
              final universitiesData = data['universities'] as List<dynamic>;
              return universitiesData
                  .map(
                    (data) => ActualUniveristy.fromMap(data as Map<String, dynamic>),
                  )
                  .toList();
            }
          }
          return [];
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: StreamBuilder<List<ActualUniveristy>>(
        stream: getFavoriteUniversitiesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) { 
            return Center(child: Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.black ,fontSize: 30),));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) { 
            return const Center(
              child: Text(
                'No favorite universities found.',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            );
          } else {
            final favorites = snapshot.data!;
            return GridView.count(
              mainAxisSpacing: size.width*0.1,
              crossAxisCount: 2,
              children: List.generate(favorites.length, (index) {
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal:size.width*0.05),
                  child: FavoritesWidget(favorite: favorites[index]),
                );
              }),
            );
          }
        },
      ),
    );
  }
}
 Future<List<ActualUniveristy>> getFavoriteUniversitiesList() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return [];
  }
  final uid = user.uid;
  try {
    final doc = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(uid)
        .get();
    if (doc.exists) {
      final data = doc.data();
      if (data != null &&
          data.containsKey('universities') &&
          data['universities'] is List) {
        final universitiesData = data['universities'] as List<dynamic>;
        return universitiesData
            .map(
              (data) => ActualUniveristy.fromMap(data as Map<String, dynamic>),
            )
            .toList();
      }
    }
    return [];
  } catch (e) {
    print('Error fetching favorites: $e');
    return [];
  }
}