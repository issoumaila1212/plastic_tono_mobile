import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import '../../components/default_btn.dart'; // Assurez-vous d'importer correctement les widgets nécessaires
import '../../widgets/infocard.dart'; // Assurez-vous d'importer votre widget InfoCard

class FinDepotScreen extends StatefulWidget {
  const FinDepotScreen({super.key});

  @override
  _FinDepotScreenState createState() => _FinDepotScreenState();
}

class _FinDepotScreenState extends State<FinDepotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Fin de dépôt',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Retour à l'écran précédent
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrer horizontalement le contenu
          mainAxisSize: MainAxisSize.min, // Réduire l'espace vertical total
          children: [
            // Réduire l'espacement entre les éléments
            Center(
              child: Image.asset(
                AppImages.logo4,
                height:
                    200, // Réduire la hauteur de l'image pour économiser de l'espace
              ),
            ),
            const SizedBox(
                height: 50), // Réduire l'espacement entre l'image et la carte
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    Text(
                      'Félicitation !',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepGreen,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Votre dépôt a été effectué avec succès.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
                height:
                    20), // Ajuster l'espacement entre la carte et les InfoCards
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InfoCard(
                  label: 'Poids',
                  value: '100 g',
                  backgroundColor: AppColors.deepGreen,
                ),
                const SizedBox(width: 16),
                InfoCard(
                  label: 'Points',
                  value: '10 pts',
                  backgroundColor: Colors.orange,
                ),
              ],
            ),
            const SizedBox(
                height:
                    40), // Ajuster l'espacement entre les InfoCards et le bouton
            defaultBtn(
              text: 'Terminer',
              btnColor: Colors.red,
              onPress: () {
                Navigator.of(context).popUntil(
                    (route) => route.isFirst); // Retourner à l'écran principal
              },
            ),
          ],
        ),
      ),
    );
  }
}
