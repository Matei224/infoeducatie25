import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studee_app/model/favoritesWidget.dart';
import 'package:studee_app/model/university.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({super.key, required this.favorites});
  List<University> favorites;
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Stream<List<University>> getFavoriteUniversitiesStream() {
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
                    (data) => University.fromMap(data as Map<String, dynamic>),
                  )
                  .toList();
            }
          }
          return [];
        });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<University>>(
        stream: getFavoriteUniversitiesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
              crossAxisCount: 2,
              children: List.generate(favorites.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
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
