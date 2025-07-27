import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

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

  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _loadImageUrl() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
      } catch (e) {
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        setState(() {
        });
      }
    }
  }

  void _showPickerOptions() {
    print('ok');
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
    Size size = MediaQuery.of(context).size;
    return Positioned(
      left: size.width * 0.5 - 86,
      bottom: -80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 6,
                    color: Color.fromARGB(255, 255, 251, 238),
                  ),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.purple[700],
                  radius: 80,
                  backgroundImage:
                      _imageUrl != null ? NetworkImage(_imageUrl!) : null,
                  child:
                      _imageUrl == null
                          ? const Icon(Icons.person, size: 50)
                          : null,
                ),
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
      ),
    );
  }
}
