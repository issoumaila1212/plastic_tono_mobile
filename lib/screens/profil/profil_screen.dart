import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import '../../components/default_btn.dart';
import '../authentification/UserService.dart';
import '../authentification/auth_sceen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final UserService _userService = UserService();
  String? _profileImageUrl; // Variable pour stocker l'URL de l'image de profil

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Charger les données utilisateur à l'initialisation
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final userData = await _userService.getUserData();
    if (userData != null) {
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _phoneController.text = userData['phone'] ?? '';
        _profileImageUrl = userData['profileImageUrl'] ?? ''; // Charger l'URL de l'image de profil
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la récupération des données utilisateur")),
      );
    }
  }

  Future<void> _uploadImage(File image) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(user.uid + '.jpg');

        await ref.putFile(image);

        final imageUrl = await ref.getDownloadURL();

        // Mettez à jour le lien de l'image de profil dans Firestore
        await _userService.updateUserData('profileImageUrl', imageUrl);

        // Rechargez l'interface avec la nouvelle image
        setState(() {
          _profileImageUrl = imageUrl;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la mise à jour de l'image")),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _uploadImage(File(image.path));
    }
  }

  Future<void> _updateUser(String field, String value) async {
    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Les champs ne peuvent être vides")),
      );
      return;
    }

    try {
      await _userService.updateUserData(field, value);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Modification réussie")),
      );
      _loadUserData(); // Rechargez les données après la mise à jour
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la modification")),
      );
    }
  }

  void _showEditDialog(String field) {
    String initialValue;
    String label;

    if (field == 'name') {
      initialValue = _nameController.text;
      label = 'Nom complet';
    } else if (field == 'phone') {
      initialValue = _phoneController.text;
      label = 'Numéro de téléphone';
    } else {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newValue = initialValue;
        return AlertDialog(
          title: Text("Modifier $label"),
          content: TextFormField(
            initialValue: initialValue,
            onChanged: (value) {
              newValue = value;
            },
            decoration: InputDecoration(hintText: "Entrez $label"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Enregistrer"),
              onPressed: () {
                Navigator.of(context).pop();
                _updateUser(field, newValue);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text('Mon profil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                      ? NetworkImage(_profileImageUrl!)
                      : null,
                  child: _profileImageUrl == null || _profileImageUrl!.isEmpty
                      ? const Icon(Icons.person, size: 80, color: Colors.orange)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.deepGreen,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildEditableField(
              label: 'Nom complet',
              controller: _nameController,
              onEdit: () => _showEditDialog('name'),
            ),
            const SizedBox(height: 16),
            _buildEditableField(
              label: 'Numéro de téléphone',
              controller: _phoneController,
              onEdit: () => _showEditDialog('phone'),
            ),
            const SizedBox(height: 30),
            defaultBtn(
              text: 'Déconnexion',
              btnColor: AppColors.deepGreen,
              onPress: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({required String label, required TextEditingController controller, required VoidCallback onEdit}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.deepGreen, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
              ),
            ),
           // IconButton(
            //  icon: Icon(Icons.edit, color: Colors.orange),
            //  onPressed: onEdit,
           // ),
          ],
        ),
      ),
    );
  }
}
