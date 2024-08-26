import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import '../../components/default_btn.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisation des contrôleurs avec des valeurs par défaut
    _nameController.text = "Abdoulaye Demba Diallo";
    _phoneController.text = "72 83 24 13";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Mon profil',
          style: TextStyle(color: Colors.white),
        ),
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
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.orange,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.deepGreen,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Logique pour changer l'image de profil
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Champ de texte pour le nom complet
            _buildEditableField(
              label: 'Nom complet',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            // Champ de texte pour le numéro de téléphone
            _buildEditableField(
              label: 'Numéro de téléphone',
              controller: _phoneController,
            ),
            const SizedBox(height: 30),
            // Bouton Déconnexion
            defaultBtn(
              text: 'Déconnexion',
              btnColor: AppColors.deepGreen,
              onPress: () {
                // Logique de déconnexion
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour construire les champs de texte modifiables
  Widget _buildEditableField({required String label, required TextEditingController controller}) {
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
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.orange,
              ),
              onPressed: () {
                // Logique pour modifier le champ
              },
            ),
          ],
        ),
      ),
    );
  }
}
