import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/widgets/points_detail_card.dart'; // Import du widget PointsDetailCard
import 'package:plastic_tono/screens/home/home_screen.dart';

class PointsDetailsScreen extends StatelessWidget {
  const PointsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Détails des points',
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
            );
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            PointsDetailCard(points: 10, reward: '1000F'),
            PointsDetailCard(points: 20, reward: '2 GO de forfait'),
            PointsDetailCard(points: 40, reward: '1000F'),
            PointsDetailCard(points: 50, reward: '15000F'),
            PointsDetailCard(points: 40, reward: '1000F'),
            PointsDetailCard(points: 10, reward: '1000F'),
          ],
        ),
      ),
    );
  }
}
