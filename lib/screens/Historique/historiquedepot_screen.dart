import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plastic_tono/widgets/list_view_historique.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';

class HistoriqueDepotScreen extends StatelessWidget {
  const HistoriqueDepotScreen({super.key});


  Future<String?> getUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
Future<List<Map<String, dynamic>>> fetchDepots() async {
    final String? userId = await getUserId();

    if (userId == null) {
      throw Exception('Utilisateur non connecté');
    }

    print('User ID: $userId');

    try {
      final response = await http.get(
          //Uri.parse('http://10.0.2.2:8080/session/historique/$userId'));
            Uri.parse('http://192.168.43.99:8080/session/historique/$userId'));

      if (response.statusCode == 200) {
        // Convertir la réponse JSON en une liste de données de dépôts
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((depot) =>
        {
          "date": depot["dateDepot"],
          "kiosque": depot["codeKiosque"],
          "poids": "${depot['poids']} Kg",
          "points": depot["points"]
        }).toList();
      } else {
        print(response.statusCode);
        return Future.value([]);
        //throw Exception('Erreur lors du chargement des dépôts');
      }
    }
    catch(e){
      print(e);
      return Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDepots(), // Appel de la fonction API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun dépôt trouvé'));
          } else {
            return HistoriqueDepotListView(
              depots: snapshot.data!,
            );
          }
        },
      ),
    );
  }
}
