import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import 'package:http/http.dart' as http;
import '../../components/default_btn.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  _SuggestionsScreenState createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final TextEditingController _suggestionsController = TextEditingController();

  @override
  void dispose() {
    _suggestionsController.dispose();
    super.dispose();
  }

  static const String baseUrl = 'http://192.168.43.99:8080/Suggestions/create';

  Future<void> addSuggestion(String texte) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'texte': texte}),
      );

      if (response.statusCode == 201) {
        // Success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Suggestion envoyée avec succès!')),
        );
        _suggestionsController.clear();
      } else {
        // Error feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${response.statusCode}. Réessayez.'),
          ),
        );
      }
    } catch (e) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur réseau. Réessayez.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text(
          'Suggestions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_satisfied_alt,
              size: 100,
              color: AppColors.deepGreen,
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Suggestions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepGreen,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _suggestionsController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Écrivez vos suggestions ici...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: AppColors.deepGreen,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    defaultBtn(
                      text: 'Envoyez',
                      btnColor: AppColors.deepGreen,
                      onPress: () {

                        if (_suggestionsController.text.isNotEmpty) {
                          addSuggestion(_suggestionsController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez écrire une suggestion.'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Image.asset(
              AppImages.logo,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}
