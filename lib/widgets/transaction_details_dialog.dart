import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'transaction_card.dart'; // Assurez-vous d'importer le modèle de transaction

class TransactionDetailsDialog extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsDialog({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détails de la Transaction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Date : ${transaction.date}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Type : ${transaction.type}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Points Convertis : ${transaction.points} pts', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Montant : 12000 Fcfa', style: const TextStyle(fontSize: 16)), // Montant fictif pour l'exemple
            const SizedBox(height: 8),
            Text('Statut : ${transaction.status}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Fermer', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
