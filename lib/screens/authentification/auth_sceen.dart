import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/authentification/register_screen.dart'; // Assurez-vous que ce chemin est correct
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';

import '../../components/default_btn.dart';
import '../../widgets/input.dart';

class AuthSceen extends StatefulWidget {
  const AuthSceen({super.key});

  @override
  State<AuthSceen> createState() => _AuthSceenState();
}

class _AuthSceenState extends State<AuthSceen> {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                        vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        input(
                          phoneCtrl: phoneCtrl,
                          icon: Icons.phone,
                          hintText: "Numéro de téléphone",
                        ),
                        const SizedBox(
                            height: 10), // Espace entre les champs de saisie
                        input(
                          phoneCtrl: passwordCtrl,
                          icon: Icons.lock,
                          hintText: "Mot de passe",
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Mot de passe oublié?",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: defaultBtn(
                            text: "Se connecter",
                            btnColor: Colors.orange,
                            onPress: () {
                              // Ajoutez votre logique de connexion ici
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
                              text: "Vous n'avez pas de compte ? ",
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Naviguer vers RegisterScreen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()),
                                      );
                                    },
                                    child: Text(
                                      "Créer un compte",
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
