import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import '../../widgets/transaction_card.dart'; // Import du widget TransactionCard
import 'package:plastic_tono/screens/home/home_screen.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Mon Historique des Transactions',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return TransactionCard(
              transaction:
                  transaction); // Utilisation du widget TransactionCard
        },
      ),
    );
  }
}

// Liste des transactions fictives
final List<Transaction> transactions = [
  Transaction(
      type: 'OrangeMoney', date: '10/12/2024', points: 100, status: 'Réussi'),
  Transaction(
      type: 'Bon d\'Achat', date: '10/12/2024', points: 100, status: 'Réussi'),
  Transaction(
      type: 'OrangeMoney', date: '10/12/2024', points: 100, status: 'Échoué'),
  Transaction(
      type: 'OrangeMoney', date: '10/12/2024', points: 100, status: 'Réussi'),
  Transaction(
      type: 'Bon d\'Achat', date: '10/12/2024', points: 100, status: 'Échoué'),
];
