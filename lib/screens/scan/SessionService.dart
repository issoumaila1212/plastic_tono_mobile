import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

        class SessionService {
         // final String baseUrl = "http://10.0.2.2:8080/session";
          final String baseUrl = "http://192.168.43.99:8080/session";
          int? _currentSessionId;

          Future<int> demarrerSession(String kioskCode) async {
            int idSession=0;
            try {
              // Obtenir le token Firebase automatiquement
              User? user = FirebaseAuth.instance.currentUser;
              String? token = await user?.getIdToken();

              if (token == null) {
                throw Exception("User not logged in or token retrieval failed");
              }

              // Préparer les données de l'utilisateur
              Map<String, dynamic> userData = {
                "phone": user?.phoneNumber,
                "name": user?.displayName,
                "email": user?.email,
              };

              // Construire la requête HTTP pour démarrer la session
              var response = await http.post(
                Uri.parse("$baseUrl/start?kioskCode=$kioskCode"),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",
                },
                body: jsonEncode(userData),
              );

              /*if (response.statusCode == 201 || response.statusCode == 200) {
                // Session démarrée avec succès
                print("Session started successfully");*/
              if (response.statusCode == 201 || response.statusCode == 200) {
                // Si la session est démarrée avec succès, extraire l'ID de session
                var responseData = jsonDecode(response.body);
                print("--------------------------------------------------");
                print(responseData['idSession']);
          print("-------------------------------------------------");

                _currentSessionId = responseData['idSession'];  // Assurez-vous que 'sessionId' est bien le nom correct du champ dans la réponse
                idSession=responseData['idSession'];
                print("--------------------------------------------------");
                print(_currentSessionId);
                print("-------------------------------------------------");
                print("Session started successfully with ID: $_currentSessionId");
              } else if (response.statusCode == 401) {
                // Non autorisé
                print("Unauthorized: ${response.statusCode}");
              } else {
                // Autre erreur
                print("Failed to start session: ${response.statusCode}");
              }
            } catch (e) {
              print("Error starting session: $e");
            }
            return idSession;
          }
/******************///////cloturer/////////////////////////////////////§§§§§§§§§§§§§§§§§§§§§§§§§§§§*********************************
        /*Future<String> cloturerSession(int idSession) async {
            print("Tentative de clôture de session. ID actuel de la session: $_currentSessionId");

            if (idSession == null) {
              print("Erreur: Aucun ID de session actif.");
              throw Exception("No active session to close");
            }

            try {
              User? user = FirebaseAuth.instance.currentUser;
              String? token = await user?.getIdToken();

              if (token == null) {
                print("Erreur: Impossible de récupérer le token Firebase.");
                throw Exception("User not logged in or token retrieval failed");
              }

              final String endpoint = "/cloturer/$idSession";
              print("Envoi de la requête à l'endpoint: $endpoint");

              final response = await http.put(
                Uri.parse(baseUrl + endpoint),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",
                },
              );

              print("Code réponse: ${response.statusCode}");

              if (response.statusCode == 200) {
                print("Session fermée avec succès.");
                return response.body;
              } else {
                print("Erreur lors de la clôture de la session: ${response.statusCode}");
                throw Exception("Erreur lors de la clôture de la session: ${response.statusCode}");
              }
            } catch (e) {
              print("Erreur: $e");
              throw Exception("Error closing session: $e");
            }
          }*/
          Future<String> cloturerSession(int? idSession) async {
            if (idSession == null || idSession == 0) {
              print("Erreur: Aucun ID de session actif ou ID de session invalide.");
              throw Exception("No active session to close");
            }

            try {
              User? user = FirebaseAuth.instance.currentUser;
              String? token = await user?.getIdToken();

              if (token == null) {
                print("Erreur: Impossible de récupérer le token Firebase.");
                throw Exception("User not logged in or token retrieval failed");
              }

              final String endpoint = "/cloturer/$idSession";
              print("Envoi de la requête à l'endpoint: $endpoint");

              final response = await http.put(
                Uri.parse(baseUrl + endpoint),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",
                },
              );

              print("Code réponse: ${response.statusCode}");

              if (response.statusCode == 200) {
                print("Session fermée avec succès.");
                return response.body;
              } else {
                print("Erreur lors de la clôture de la session: ${response.statusCode}");
                throw Exception("Erreur lors de la clôture de la session: ${response.statusCode}");
              }
            } catch (e) {
              print("Erreur: $e");
              throw Exception("Error closing session: $e");
            }
          }

          /******************///////  ////******************************///////recuperer poids::::::::*******************::::::::::::

          Future<int> fetchPoidsSession(int idSession) async {
           // final response = await http.get(Uri.parse('http://10.0.2.2:8080/session/getPoids/$idSession'));
            final response = await http.get(Uri.parse('http://192.168.43.99:8080/session/getPoids/$idSession'));

            if (response.statusCode == 200) {
              return jsonDecode(response.body); // Récupérer le poids comme un entier
            } else {
              throw Exception('Erreur lors de la récupération du poids');
            }
          }
///////////////////******************espace points******************////////////////////////////////////////////////////

          Future<void> enregistrerPoints(int sessionId, int poids) async {
            final String url = "$baseUrl/$sessionId/enregistrerPoints?poids=$poids";

            try {
              final response = await http.post(Uri.parse(url));

              if (response.statusCode == 200) {
                print("Points enregistrés avec succès");
                var pointsData = jsonDecode(response.body);
                print("Points: ${pointsData['points']}");
              } else {
                print("Erreur lors de l'enregistrement des points: ${response.statusCode}");
              }
            } catch (e) {
              print("Erreur: $e");
            }
          }


          Future<double> getPoints(int sessionId) async {
            final String url = "$baseUrl/$sessionId/points";

            try {
              final response = await http.get(Uri.parse(url));

              if (response.statusCode == 200) {
                var pointsData = jsonDecode(response.body);
                return pointsData;
              } else {
                print("Erreur lors de la récupération des points: ${response.statusCode}");
                return 0;
              }
            } catch (e) {
              print("Erreur: $e");
              return 0;
            }
          }


          /*Future<String> cloturerSession(String kioskCode) async {
            print("Tentative de clôture de session avec le code kiosque : $kioskCode");

            try {
              // Obtenir l'utilisateur actuel et le token Firebase
              User? user = FirebaseAuth.instance.currentUser;
              String? token = await user?.getIdToken();

              if (user == null || token == null) {
                print("Erreur: Impossible de récupérer l'utilisateur ou le token Firebase.");
                throw Exception("User not logged in or token retrieval failed");
              }

              // Construire l'URL de l'API avec le userId (user.uid) et le kioskCode
              final String endpoint = "/cloturer?userId=${user.uid}&kioskCode=$kioskCode";
              print("Envoi de la requête à l'endpoint: $endpoint");

              final response = await http.put(
                Uri.parse(baseUrl + endpoint),
                headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $token",  // Utiliser le token Firebase pour l'autorisation
                },
              );

              // Vérifier la réponse du serveur
              print("Code réponse: ${response.statusCode}");

              if (response.statusCode == 200) {
                print("Session fermée avec succès.");
                return response.body;
              } else {
                print("Erreur lors de la clôture de la session: ${response.statusCode}");
                throw Exception("Erreur lors de la clôture de la session: ${response.statusCode}");
              }
            } catch (e) {
              print("Erreur: $e");
              throw Exception("Error closing session: $e");
            }
          }*/



        }
