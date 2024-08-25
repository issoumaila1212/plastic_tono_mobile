import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/widgets/pointoption.dart'; // Assurez-vous que le chemin d'importation est correct

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Convertir mes points',
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
            );
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: PointsOptions(), // Utiliser le widget PointsOptions ici
      ),
    );
  }
}
