import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';

import '../../components/default_btn.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

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
                // Section supérieure - Logo
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.logo,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Section inférieure - Félicitations
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.deepGreen,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Aligner en haut
                      children: [
                        // Icône de succès
                        Icon(
                          Icons.check_circle_outline,
                          color: AppColors.white,
                          size: 80,
                        ),
                        const SizedBox(height: 20),
                        // Message de succès
                        Text(
                          "Félicitations ! Votre compte a été créé avec succès.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Nous sommes ravis de vous compter parmi nous.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Bouton "Commencer"
                        defaultBtn(
                          text: "Commencer",
                          btnColor: Colors.orange,
                          onPress: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
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
