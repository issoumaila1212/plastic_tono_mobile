import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';

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
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
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
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Image.asset(
                        AppImages.logo,
                        width: 200,
                        fit: BoxFit.contain,
                      )),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppColors.deepGreen,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        children: [
                          //titre
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Text(
                              "Créons votre compte",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          //sous titre
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Créez votre compte gratuitement et valoriser vos dechets plastiques!",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Champ Nom complet
                          input(
                            phoneCtrl: nameCtrl,
                            icon: Icons.person,
                            hintText: "Nom complet",
                          ),
                          // Champ Numéro de téléphone
                          input(
                            phoneCtrl: phoneCtrl,
                            icon: Icons.phone,
                            hintText: "Numéro de téléphone",
                          ),
                          // Champ Mot de passe
                          input(
                            phoneCtrl: passwordCtrl,
                            icon: Icons.lock,
                            hintText: "Mot de passe",
                            isPassword: true,
                          ),
                          // Champ Confirmation du mot de passe
                          input(
                            phoneCtrl: confirmPasswordCtrl,
                            icon: Icons.lock,
                            hintText: "Confirmation du mot de passe",
                            isPassword: true,
                          ),
                          // Bouton Créer un compte
                          defaultBtn(
                            text: "Créer un compte",
                            btnColor: Colors.orange,
                            onPress: () {
                              // Logique de création de compte
                              print("Créer un compte appuyé");
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
