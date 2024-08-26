import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/screens/point/convertpoint_screen.dart';
import 'package:plastic_tono/screens/point/points_details_screen.dart';

class PointsOptions extends StatelessWidget {
  const PointsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(), // Ajout d'un espace flexible au-dessus
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 120, // Contrôle de la largeur du bouton
                  height: 180, // Contrôle de la hauteur du bouton
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConvertPointsScreen(),
                        ),
                      ); // Logique pour convertir les points
                    },
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Ajuste la taille du contenu
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Fond blanc pour le cercle
                          ),
                          child: Icon(
                            Icons.swap_vert,
                            size: 30,
                            color: AppColors.deepGreen, // Couleur de l'icône
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Convertir mes points',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 120, // Contrôle de la largeur du bouton
                  height: 180, // Contrôle de la hauteur du bouton
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PointsDetailsScreen(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Ajuste la taille du contenu
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white, // Fond blanc pour le cercle
                          ),
                          child: Icon(
                            Icons.info,
                            size: 30,
                            color: Colors.orange, // Couleur de l'icône
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Détails des points',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(), // Ajout d'un espace flexible en dessous pour centrer verticalement
      ],
    );
  }
}
