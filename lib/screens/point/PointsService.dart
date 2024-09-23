import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';



      class PointsService{
        Future<String?> getUserId() async{
          final User? user = FirebaseAuth.instance.currentUser;
          return user?.uid;
        }
         Future<double> fetchUserPoints() async{
          final String? userId = await getUserId();

          if (userId == null){
            throw Exception('Utilisateur non connecté');
          }
          final response = await http.get(
            Uri.parse('http://192.168.43.99:8080/points/total/$userId'),
          // Uri.parse('http://10.175.48.122:8080/total/$userId'),
          );
          if (response.statusCode == 200) {
            return double.parse(response.body);
          } else {
            throw Exception('Erreur lors du chargement des points');
          }
         }


        Future<void> convertirPointsEnArgent(double points) async {
          final String? userId = await getUserId();

          try {
            final response = await http.post(
              Uri.parse('http://192.168.43.99:8080/points/convert?userId=$userId'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'points': points,
              }),
            );

            if (response.statusCode == 200) {
              print('Conversion réussie');
            } else {
              print('Erreur lors de la conversion: ${response.statusCode}');
            }
          } catch (e) {
            print('Erreur: $e');
          }
        }


      }