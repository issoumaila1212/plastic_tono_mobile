import 'package:flutter/material.dart';
import 'package:plastic_tono/widgets/list_view_historique.dart'; // Assurez-vous d'importer correctement le fichier du widget
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';

class HistoriqueDepotScreen extends StatelessWidget {
  const HistoriqueDepotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simuler une liste de données de dépôts pour l'exemple
    final List<Map<String, dynamic>> depots = [
      {
        "date": "10/12/2024",
        "kiosque": "Kiosque1",
        "poids": "2,5 Kg",
        "points": 30
      },
      {
        "date": "11/12/2024",
        "kiosque": "Kiosque2",
        "poids": "3,0 Kg",
        "points": 25
      },
      {
        "date": "12/12/2024",
        "kiosque": "Kiosque3",
        "poids": "1,5 Kg",
        "points": 29
      },
      {
        "date": "13/12/2024",
        "kiosque": "Kiosque4",
        "poids": "2,0 Kg",
        "points": 22
      },
      {
        "date": "14/12/2024",
        "kiosque": "Kiosque5",
        "poids": "2,8 Kg",
        "points": 22
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Mon Historique des dépôts',
          style: TextStyle(color: Colors.white),
        ),
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
        centerTitle: true,
      ),
      body: HistoriqueDepotListView(
          depots: depots), // Utiliser le widget ListView
    );
  }
}
