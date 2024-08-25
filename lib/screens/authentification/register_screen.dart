import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/authentification/auth_sceen.dart'; // Assurez-vous que ce chemin est correct
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import 'package:plastic_tono/screens/authentification/validation_screen.dart';

import '../../components/default_btn.dart';
import '../../widgets/input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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
                  color: AppColors.white,
                  child: Image.asset(
                    AppImages.logo,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.deepGreen,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Créons votre compte",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Créez votre compte gratuitement et valorisez vos déchets plastiques !",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        input(
                          phoneCtrl: nameCtrl,
                          icon: Icons.person,
                          hintText: "Nom complet",
                        ),
                        const SizedBox(height: 10),
                        input(
                          phoneCtrl: phoneCtrl,
                          icon: Icons.phone,
                          hintText: "Numéro de téléphone",
                        ),
                        const SizedBox(height: 10),
                        input(
                          phoneCtrl: emailCtrl,
                          icon: Icons.email,
                          hintText: "Email",
                        ),
                        const SizedBox(height: 10),
                        input(
                          phoneCtrl: passwordCtrl,
                          icon: Icons.lock,
                          hintText: "Mot de passe",
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: defaultBtn(
                            text: "Créer un compte",
                            btnColor: Colors.orange,
                            onPress: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ValidationScreen()),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                              ),
                              text: "Si vous avez déjà un compte ? ",
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Naviguer vers AuthScreen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AuthSceen()),
                                      );
                                    },
                                    child: Text(
                                      "Connectez-vous",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
