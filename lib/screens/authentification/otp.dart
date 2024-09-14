import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userPhone;
  String? verificationId;

  Future<String?> verifyPhoneNumberWithGoogle(setMessage(String message),
      {
        required BuildContext context,
        required String numeroPhone,
      }) async {
    String? errorMessage;
    // Vérifiez si le numéro de téléphone est valide
    if (numeroPhone.trim() == "") {
      errorMessage = 'Le numéro de téléphone n\'est pas valide.';
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        auth.setSettings();
        // Envoyez un SMS de vérification
        await auth.verifyPhoneNumber(
          phoneNumber: numeroPhone,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential).then((value) {
              print('Logged In Successfully');
            });
          },
          verificationFailed: (error) {
            print(error.message);
            //codeSend = false;
            errorMessage = error.message;
          },
          //autoRetrievedSmsCodeForTesting: ,
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
            print('Code envoyé');
            userPhone = numeroPhone;
            //codeSend = true;
            //lesmsCode = credential.smsCode ?? "";
            //  Redirection to confirm page
            notifyListeners();
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            print('TimeOut');
            errorMessage = "Délai dépassé,veuillez réessayer!";
            notifyListeners();
          },
          timeout: const Duration(seconds: 120),
        );
      } catch (e) {
        errorMessage = "Erreur! veuillez réessayer";
        notifyListeners();
      }
    }
  }


}