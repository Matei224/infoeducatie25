import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studee_app/main.dart';

class ProfileUniv extends StatefulWidget {
  ProfileUniv({super.key, required this.univ, required this.index});
  String univ;
  final int index;
  @override
  State<ProfileUniv> createState() => _ProfileUnivState();
}

class _ProfileUnivState extends State<ProfileUniv> {
  bool isSelect = false;
  List<String>? listOfUnivs = [];
  void showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void updateUnivAtIndex(String newUniv, int index) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showSnackBar("No user logged in");
      return;
    }

    DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    try {
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        List<dynamic> univs = doc.get('topUnivs') ?? [];

        univs[index] = newUniv;

        await docRef.update({'topUnivs': univs});
        showSnackBar("First university updated successfully");
      } else {
        List<String> univs = List.filled(index, "");
        univs.add(newUniv);
        await docRef.set({'topUnivs': univs});
        showSnackBar("First university added successfully");
      }
    } catch (e) {
      showSnackBar("Error updating university: $e");
    }
  }

  void onSubjectOfInterestTap() {
    DropDownState<String>(
      dropDown: DropDown<String>(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Select',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.black),
        ),
        submitButtonText: 'Save',
        clearButtonText: 'Clear',
        data: names,
        onSelected: (selectedItems) {
          String newUniv =
              selectedItems.isNotEmpty ? selectedItems[0].data : "";
          setState(() {
            widget.univ = newUniv.isNotEmpty ? newUniv : "Select university";
          });
          updateUnivAtIndex(newUniv, widget.index);
        },

        enableMultipleSelection: false,
        maxSelectedItems: 1,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      width: size.width * 0.53,

      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 234, 218, 255),
          width: 1.2,
        ),
        color: Color.fromARGB(255, 234, 218, 255),
        borderRadius: BorderRadius.circular(8.0), 
      ),

      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: onSubjectOfInterestTap,
                icon: Icon(Icons.keyboard_arrow_up_outlined),
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: Text(generateAbbreviation(widget.univ), style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }
}
  String generateAbbreviation(String name) {
    List<String> words = name.split(' ');
    String abbreviation = '';
    for (String word in words) {
      if (word.isNotEmpty && word[0] == word[0].toUpperCase()) {
        abbreviation += word[0];
      }
    }
    return abbreviation;
  }
