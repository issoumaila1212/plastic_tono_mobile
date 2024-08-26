import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/widgets/notificationcard.dart'; // Assurez-vous d'importer le widget NotificationCard
import 'package:plastic_tono/screens/home/home_screen.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Mes Notifications',
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
      body: ListView(
        children: const [
          NotificationCard(
            title: 'Information',
            message:
                'Nous avons récemment mis à jour notre application. Veuillez télécharger...',
            date: '10/12/2024',
            type: 'Information',
            color: Colors.orange,
          ),
          NotificationCard(
            title: 'Avertissement',
            message:
                'Un objet non conforme a été détecté lors de votre dernier dépôt. Veuillez ne déposer...',
            date: '10/12/2024',
            type: 'Avertissement',
            color: Colors.red,
          ),
          NotificationCard(
            title: 'Promotion',
            message:
                'Bonne nouvelle ! Gagnez 20% de points supplémentaires sur chaque dépôt de...',
            date: '10/12/2024',
            type: 'Promotion',
            color: AppColors.deepGreen,
          ),
          NotificationCard(
            title: 'Session Terminé',
            message:
                'Félicitations ! Vous avez terminé votre session de dépôt...',
            date: '10/12/2024',
            type: 'Session',
            color: Colors.orange,
          ),
          NotificationCard(
            title: 'Transaction réussi',
            message: 'Votre transaction a été complétée avec succès...',
            date: '10/12/2024',
            type: 'Transaction',
            color: AppColors.deepGreen,
          ),
        ],
      ),
    );
  }
}
