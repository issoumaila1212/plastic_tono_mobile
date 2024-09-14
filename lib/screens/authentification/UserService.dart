import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //////////µµµµµµµ%%%%%%%%%%%%%%% avoir le token %%%%%%%%%%%%%///////////////

  ///////////////////%%%%%%%%%%%%%µµµµµµµµµµµµµµµ***************creer user%%%%%%%%%%££££££££££µµµµµµµ//////////////////
  Future<void> registerUser(String name, String phone, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Créer un document avec l'UID de l'utilisateur
        await _firestore.collection('Mobiles').doc(user.uid).set({
          'name': name,
          'phone': phone,
          'email': email,
          'userId': user.uid,
        });

        print("Utilisateur enregistré avec succès avec l'ID: ${user.uid}");
      }
    } catch (e) {
      print("Erreur lors de l'inscription : $e");
    }
  }

////////////////////µµµµµµµµµµµµµ*****************connexion authentification *******$$$$$$$$$$$ùùùùùùùùùùù
  // Connexion d'un utilisateur existant avec email et mot de passe
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print("Erreur lors de la connexion : $e");
      return null;
    }
  }

  /////££µ*************#############// Récupérer les ifo de users//////////**********$$$$$$$$$$
  Future<Map<String, String>?> getUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        print("Utilisateur non authentifié");
        return null;
      }

      /////******$$$$$$$$$//autre methodes Récupérer le document utilisateur depuis Firestore//////////§!!!!!!!!
      DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
          .collection('Mobiles')  // Assurez-vous que la collection s'appelle bien 'Mobiles'
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data();
        return {
          'name': data?['name'] ?? '',
          'phone': data?['phone'] ?? '',
        };
      } else {
        print("Le document pour l'utilisateur avec UID ${user.uid} n'existe pas");
        return null;
      }
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
      return null;
    }
  }

    /////////ùùùùùùùùù*******####%%%%%%%%%Modification des infosµµµ££££££££££££££///////////############
  Future<void> updateUserData(String name, String phone) async{
    try{
      User? user = _auth.currentUser;
      if(user!= null){
        await _firestore.collection('Mobiles').doc(user.uid).update({
          'name':name,
          'phone':phone,
        });
        print("Données de user mises à jour");
      }
    }catch (e){
     print("Erreur lors de la mise a jour : $e" );
    }
  }

















  // Envoyer un code OTP au numéro de téléphone
  Future<void> sendOTP(String phoneNumber, Function(String) codeSentCallback, Function(String) errorCallback) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-connexion si le code est détecté automatiquement
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Callback d'erreur si l'envoi du code échoue
          errorCallback(e.message ?? "Erreur lors de l'envoi du code OTP");
        },
        codeSent: (String verificationId, int? resendToken) {
          // Callback de succès avec le verificationId
          codeSentCallback(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Code timeout
        },
      );
    } catch (e) {
      // Callback d'erreur si quelque chose d'autre échoue
      errorCallback(e.toString());
    }
  }

  // Vérifier le code OTP
  Future<void> verifyOTP(String verificationId, String otp, Function onSuccess, Function(String) onError) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      onSuccess();
    } catch (e) {
      onError(e.toString());
    }
  }



}

