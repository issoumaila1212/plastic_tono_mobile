import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/scan/SessionService.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import '../../components/default_btn.dart';
import '../../widgets/infocard.dart';
import '../home/home_screen.dart';

class FinDepotScreen extends StatefulWidget {
  final int idSession;

  const FinDepotScreen({super.key, required this.idSession});

  @override
  _FinDepotScreenState createState() => _FinDepotScreenState();
}

class _FinDepotScreenState extends State<FinDepotScreen> {
  int poids = 0;
  String points = "0";
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    _getPoidsSession();
    _enregistrerPoints();

  }

  Future<void> _getPoidsSession() async {
    try {
      int fetchedPoids = await _sessionService.fetchPoidsSession(widget.idSession);
      setState(() {
        poids = fetchedPoids;
      });
    } catch (e) {
      print('Erreur lors de la récupération du poids : $e');
    }
  }

  Future<void> _enregistrerPoints() async {
    try {
      await _sessionService.enregistrerPoints(widget.idSession, poids);
      print("---------------------------------------object");


      double fetchedPoints = await _sessionService.getPoints(widget.idSession);
      print("---------------------------------------points::::");
      print(fetchedPoints);
      setState(() {
        points = fetchedPoints.toStringAsFixed(2);

      });
    } catch (e) {
      print('Erreur lors de l\'enregistrement des points : $e');
    }
  }

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
                  value: '$poids g',
                  backgroundColor: AppColors.deepGreen,
                ),
                const SizedBox(width: 16),
                InfoCard(
                  label: 'Points',
                  value: '$points pts',
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                ); // Retourner à l'écran principal
              },
            ),
          ],
        ),
      ),
    );
  }
}
