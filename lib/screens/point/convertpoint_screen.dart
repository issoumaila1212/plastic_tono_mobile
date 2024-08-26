import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/screens/point/point_screen.dart';
import '../../components/default_btn.dart'; // Assurez-vous d'importer correctement vos widgets personnalisés
import '../../widgets/input.dart'; // Assurez-vous d'importer le widget `input` si nécessaire
import 'package:plastic_tono/screens/home/home_screen.dart';

class ConvertPointsScreen extends StatefulWidget {
  const ConvertPointsScreen({super.key});

  @override
  State<ConvertPointsScreen> createState() => _ConvertPointsScreenState();
}

class _ConvertPointsScreenState extends State<ConvertPointsScreen> {
  bool showConversionFields =
      false; // Booléen pour afficher les champs supplémentaires

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Mes Points',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ); // Retour à l'écran précédent
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Carte affichant les points disponibles
              Card(
                color: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Points disponibles',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '1200',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Bouton "Convertir"
              defaultBtn(
                text: 'Convertir',
                btnColor: AppColors.deepGreen,
                onPress: () {
                  setState(() {
                    showConversionFields =
                        true; // Afficher les champs supplémentaires
                  });
                },
              ),
              if (showConversionFields) ...[
                const SizedBox(height: 16),
                // Champ de saisie "Mobile Money"
                input(
                  phoneCtrl:
                      TextEditingController(), // Utilisez un TextEditingController adapté
                  hintText: 'Mobile Money (Orange Money)',
                  icon: Icons.phone_iphone,
                ),
                const SizedBox(height: 16),
                // Champ de saisie "Nombre de points à convertir"
                input(
                  phoneCtrl:
                      TextEditingController(), // Utilisez un TextEditingController adapté
                  hintText: 'Nombre de points à convertir',
                  icon: Icons.calculate,
                ),
                const SizedBox(height: 16),
                // Bouton "Confirmer"
                defaultBtn(
                  text: 'Confirmer',
                  btnColor: AppColors.deepGreen,
                  onPress: () {
                    // Logique de confirmation de conversion
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
