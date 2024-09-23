import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/authentification/UserService.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import '../../components/default_btn.dart';
import '../../widgets/input.dart';
import '../authentification/auth_sceen.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final UserService _userService = UserService();

  /*
  void doLoginWithPhone(String phone) async {
    try {
      _userService.sendOTP(
          phone, (String verifyId) {}, (String errorMessage) {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la création du compte")),
      );
    }
  }*/

  bool isLoading = false;
  // Fonction pour valider les champs
  bool validateFields() {
    // Valider le nom (max 50 caractères)
    if (nameCtrl.text.isEmpty || nameCtrl.text.length > 50) {
      _showError("Le nom doit contenir entre 1 et 50 caractères.");
      return false;
    }

    // Valider le numéro de téléphone (doit contenir exactement 8 chiffres sans le code pays)
    String phone = phoneCtrl.text.trim();
    if (!phone.startsWith('+223') || phone.length != 12) {
      _showError("Le numéro doit commencer par +223 et contenir 8 chiffres après.");
      return false;
    }


    // Valider le mot de passe (min 8 caractères, 1 majuscule, 1 minuscule, 1 chiffre, 1 caractère spécial)
    String password = passwordCtrl.text;
    if (!_isValidPassword(password)) {
      _showError("Le mot de passe doit contenir au moins 8 caractères, incluant une majuscule, une minuscule, un chiffre et un caractère spécial.");
      return false;
    }

    return true;
  }

  // Fonction pour afficher un message d'erreur
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Fonction pour valider la robustesse du mot de passe
  bool _isValidPassword(String password) {
    final passwordRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegExp.hasMatch(password);
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
                      vertical: 10,
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
                          isName: true,
                        ),
                        const SizedBox(height: 10),
                        input(
                          phoneCtrl: phoneCtrl,
                          icon: Icons.phone,
                          hintText: "Numéro de téléphone",
                          isPhone: true,
                        ),
                        const SizedBox(height: 10),
                        input(
                          phoneCtrl: emailCtrl,
                          icon: Icons.email,
                          hintText: "Email",
                          isEmail: true,
                        ),
                        const SizedBox(height: 10),
                        input(
                          phoneCtrl: passwordCtrl,
                          icon: Icons.lock,
                          hintText: "Mot de passe",
                          isPassword: true,

                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: defaultBtn(
                            text: isLoading ? "Chargement..." : "Créer un compte",
                            btnColor: Colors.orange,
                            onPress: isLoading ? null : () async {
                              // Valider les champs
                              if (!validateFields()) return;

                              setState(() {
                                isLoading = true;
                              });

                              try {
                                await _userService.registerUser(
                                  nameCtrl.text.trim(),
                                  phoneCtrl.text.trim(),
                                  emailCtrl.text.trim(),
                                  passwordCtrl.text.trim(),
                                );

                                print("Compte créé avec succès");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                                );
                              } catch (e) {
                                _showError("Erreur lors de la création du compte");
                              }

                              setState(() {
                                isLoading = false;
                              });
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const AuthScreen()),
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
