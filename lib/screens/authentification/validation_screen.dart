import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import '../../components/default_btn.dart';
import '../../widgets/verificationcodeBox.dart';
import '../home/home_screen.dart';

class ValidationScreen extends StatefulWidget {
  final String verificationId;

  const ValidationScreen({required this.verificationId, Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final TextEditingController _code1 = TextEditingController();
  final TextEditingController _code2 = TextEditingController();
  final TextEditingController _code3 = TextEditingController();
  final TextEditingController _code4 = TextEditingController();
  final TextEditingController _code5 = TextEditingController();
  final TextEditingController _code6 = TextEditingController();

  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fonction pour assembler le code OTP
  String get _smsCode {
    return _code1.text.trim() +
        _code2.text.trim() +
        _code3.text.trim() +
        _code4.text.trim() +
        _code5.text.trim() +
        _code6.text.trim();
  }

  // Fonction pour vérifier le code OTP
  Future<void> _verifyOTP() async {
    setState(() {
      _isLoading = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _smsCode,
      );

      await _auth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la vérification : ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                      'assets/images/logo.png',
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.deepGreen,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                        Text(
                          "Un code de vérification à 6 chiffres a été envoyé à votre numéro de téléphone. Veuillez le saisir pour confirmer votre identité.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        // Les 6 champs de saisie pour l'OTP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            VerificationCodeBox(controller: _code1),
                            VerificationCodeBox(controller: _code2),
                            VerificationCodeBox(controller: _code3),
                            VerificationCodeBox(controller: _code4),
                            VerificationCodeBox(controller: _code5),
                            VerificationCodeBox(controller: _code6),
                          ],
                        ),
                        const SizedBox(height: 30),
                        defaultBtn(
                          text: _isLoading ? "Vérification..." : "Continuer",
                          btnColor: AppColors.orange,
                          onPress: _isLoading ? null : _verifyOTP,
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
