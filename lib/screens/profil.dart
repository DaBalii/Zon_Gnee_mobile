import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  final Function(String?) updateProfilePhoto;

  const UserPage({Key? key, required this.updateProfilePhoto})
      : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  File? _selectedImage;
  bool _isImageChanged = false;
  final ImagePicker picker = ImagePicker();

  final String _selectedImagePathKey = 'selectedImagePath';

  List<String> profileImages = [
    'images/profile1.png',
    'images/profile2.png',
    'images/profile3.png',
  ];

  UserProfile? _userProfile; // Ajout de la variable pour le profil utilisateur

  @override
  void initState() {
    super.initState();
    _loadSelectedImagePath();
    _loadUserProfile(); // Charger le profil utilisateur lors de l'initialisation de l'état
  }

  void _loadSelectedImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedImagePath = prefs.getString(_selectedImagePathKey);

    if (selectedImagePath != null) {
      setState(() {
        _selectedImage = File(selectedImagePath);
        _isImageChanged = true;
      });
    }
  }

  void _saveSelectedImagePath(String? imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedImagePathKey, imagePath ?? '');
  }

  void _loadUserProfile() {
    // Charger les informations du profil utilisateur depuis une source de données (par exemple, une base de données)
    // Ici, vous pouvez utiliser les méthodes appropriées pour récupérer les données du profil utilisateur
    // et les assigner à la variable _userProfile

    _userProfile = UserProfile(
      name: "Fakiss",
      email: "fakissjoli@gmail.com",
      phoneNumber: "+228 22450235",
      bio: "Je suis un passionné de l'immobilier.",
      profileImage: "images/profile1.png",
    );
  }

  void _pickImage() async {
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      setState(() {
        _selectedImage = File(imagePicked.path);
        _isImageChanged = true;
      });

      _saveSelectedImagePath(_selectedImage?.path);
      widget.updateProfilePhoto(_selectedImage?.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF707070),
            ),
            child: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Profil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Espace entre l'appbar et le contenu

          // Espace réservé aux images de profil
          CircleAvatar(
            radius: 50,
            backgroundImage: _isImageChanged
                ? FileImage(_selectedImage!)
                : AssetImage(profileImages[0]) as ImageProvider,
          ),

          SizedBox(height: 20),
          // Espace entre les images de profil et le bouton

          // Affichage des informations du profil utilisateur
          Text(
            _userProfile?.name ?? "",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(_userProfile?.email ?? ""),
          Text(_userProfile?.phoneNumber ?? ""),
          Text(_userProfile?.bio ?? ""),

          // Bouton "Changer photo de profil"
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Changer photo de profil'),
          ),
        ],
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String phoneNumber;
  final String bio;
  final String profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.bio,
    required this.profileImage,
  });
}
