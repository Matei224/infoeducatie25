import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  String? _imageUrl;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _loadImageUrl();
  }

  // Load the image URL from Firebase Storage when the widget initializes
  Future<void> _loadImageUrl() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        //  final ref = FirebaseStorage.instance.ref().child(
        //      'images/$userId/profile.jpg',
        //   );
        //   final url = await ref.getDownloadURL();
        //   setState(() {
        //     _imageUrl = url;
        //    });
      } catch (e) {
        // Handle error, e.g., image not found
      }
    }
  }

  // Pick an image from gallery or camera and upload it to Firebase Storage
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        //   final ref = FirebaseStorage.instance.ref().child(
        //    'images/$userId/profile.jpg',
        //   );
        //   await ref.putFile(File(pickedFile.path));
        //  final url = await ref.getDownloadURL();
        setState(() {
          //     _imageUrl = url;
        });
      }
    }
  }

  // Show options to pick from gallery or camera
  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage:
                  _imageUrl != null ? NetworkImage(_imageUrl!) : null,
              child:
                  _imageUrl == null ? const Icon(Icons.person, size: 50) : null,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: _showPickerOptions,
                  onHover: (hovering) {
                    setState(() {
                      _isHovered = hovering;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: _isHovered ? Colors.purple[700] : Colors.purple,
                      boxShadow:
                          _isHovered
                              ? [
                                const BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 80,
                                ),
                              ]
                              : [],
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: const Text(
                      'Change picture',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
