import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/authentification/register_screen.dart';
import 'package:plastic_tono/screens/authentification/success_screen.dart';
import 'package:plastic_tono/screens/authentification/validation_screen.dart'; // Remplacez ou supprimez si non nécessaire
import 'package:plastic_tono/themes/color/app_colors.dart';
import '../../components/default_btn.dart';
import '../../themes/images/app_images.dart';
import '../../widgets/input.dart';
import 'UserService.dart';
import '../home/home_screen.dart'; // Importer l'écran de destination après connexion

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final UserService _userService = UserService();
  bool isLoading = false;

  void _handleSignIn() async {
    setState(() {
      isLoading = true;
    });

    User? user = await _userService.signIn(
      emailCtrl.text.trim(),
      passwordCtrl.text.trim(),
    );

    if (user != null) {
      // Si la connexion est réussie, naviguez vers l'écran d'accueil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    } else {
      // Affiche un message d'erreur si la connexion échoue
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur de connexion. Vérifiez vos identifiants.")),
      );
    }

    setState(() {
      isLoading = false;
    });
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
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            text: isLoading ? "Connexion en cours..." : "Se connecter",
                            btnColor: Colors.orange,
<<<<<<< Updated upstream
                            onPress: () {
                              // Ajoutez votre logique de connexion ici
                            },
=======
                            onPress: isLoading ? null : _handleSignIn,
>>>>>>> Stashed changes
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(color: AppColors.white, fontSize: 12),
                              text: "Vous n'avez pas de compte ? ",
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
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
