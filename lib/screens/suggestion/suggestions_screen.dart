import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
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
            // Icones de suggestion
            Icon(
              Icons.sentiment_satisfied_alt,
              size: 100,
              color: AppColors.deepGreen,
            ),
            const SizedBox(height: 20),
            // Card pour suggestions
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
                    // Champ de saisie de texte pour les suggestions
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
                    // Bouton Envoyer
                    defaultBtn(
                      text: 'Envoyez',
                      btnColor: AppColors.deepGreen,
                      onPress: () {
                        // Logique pour envoyer la suggestion
                        if (_suggestionsController.text.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Suggestion envoyée!'),
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
            // Logo en bas de la page
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
