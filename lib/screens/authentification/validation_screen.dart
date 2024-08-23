import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import '../../components/default_btn.dart';
import '../../widgets/verificationcodeBox.dart';
import '../../screens/authentification/success_screen.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final TextEditingController _code1 = TextEditingController();
  final TextEditingController _code2 = TextEditingController();
  final TextEditingController _code3 = TextEditingController();
  final TextEditingController _code4 = TextEditingController();

  bool _isLoading = false; // Variable pour gérer l'état de chargement

  // Fonction pour afficher le dialogue de chargement
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Vérification en cours...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  // Simulation d'une fonction de vérification du code
  Future<void> _verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    _showLoadingDialog(context); // Affiche le dialogue de chargement

    // Simule un délai pour la vérification (par exemple, une requête réseau)
    await Future.delayed(const Duration(seconds: 3));

    // Ferme le dialogue de chargement
    Navigator.of(context).pop();

    setState(() {
      _isLoading = false;
    });

    // Après vérification réussie, navigue vers la page de succès
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.logo,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Section inférieure - Vérification
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.deepGreen,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          "Vérification d’identité",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        //sous titre
                        Text(
                          "Un code de vérification a été envoyé à votre e-mail. Veuillez le saisir pour confirmer votre identité.",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: AppColors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        //champ de saisie de code
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            VerificationCodeBox(
                              controller: _code1,
                              autoFocus: true,
                            ),
                            VerificationCodeBox(controller: _code2),
                            VerificationCodeBox(controller: _code3),
                            VerificationCodeBox(controller: _code4)
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultBtn(
                          text: "Continuer",
                          btnColor: AppColors.orange,
                          onPress: _isLoading
                              ? null
                              : () async {
                                  // Ajoutez 'async' ici
                                  // Logique pour la vérification du code
                                  final code = _code1.text +
                                      _code2.text +
                                      _code3.text +
                                      _code4.text;
                                  print("Code saisi: $code");

                                  // Appel de la fonction de vérification
                                  await _verifyCode(); // Ceci est maintenant correct
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
