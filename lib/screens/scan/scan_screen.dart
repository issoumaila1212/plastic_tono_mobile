import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import '../../components/default_btn.dart';
import '../../widgets/input.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool showQrCode = true; // Par défaut, on affiche le QR code
  bool isCodeValid =
      true; // Ajout d'un booléen pour gérer l'affichage du message d'erreur

  final GlobalKey qrKey =
      GlobalKey(debugLabel: 'QR'); // Déclaration de la clé QR
  QRViewController? controller; // Déclaration du contrôleur QR
  String? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: Text(
          showQrCode ? 'Scanner code QR' : 'Saisi du code kiosque',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ); // Retour à l'écran précédent (probablement HomeScreen)
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AppImages.logo3,
                height: 150, // Augmentation de la taille de l'image
              ),
            ),
            const SizedBox(height: 16),
            // Boutons de sélection (QR code ou Code kiosque) avec `defaultBtn`
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: defaultBtn(
                    text: 'Qr code',
                    btnColor: showQrCode ? Colors.orange : AppColors.orange,
                    onPress: () {
                      setState(() {
                        showQrCode = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: defaultBtn(
                    text: 'Code Kiosque',
                    btnColor: showQrCode ? Colors.green : AppColors.deepGreen,
                    onPress: () {
                      setState(() {
                        showQrCode =
                            false; // Affiche le champ de saisie du code kiosque
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Contenu dynamique basé sur le choix
            if (showQrCode)
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.green,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
              )
            else
              Column(
                children: [
                  Text(
                    'Saisissez le code du kiosque',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Champ de saisie du code kiosque avec widget `input`
                  input(
                    phoneCtrl:
                        TextEditingController(), // Utilisez un TextEditingController adapté
                    icon: Icons.code,
                    hintText: "---------",
                  ),
                  const SizedBox(height: 16),
                  // Bouton de validation avec `defaultBtn`
                  defaultBtn(
                    text: 'Valider',
                    btnColor: AppColors.deepGreen,
                    onPress: () {
                      // Logique de validation du code kiosque
                    },
                  ),
                ],
              ),
            const Spacer(),
            // Message d'erreur ou de succès basé sur la validité du code
            if (isCodeValid)
              Text(
                'Kiosque ACI00 identifié avec succès',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.deepGreen,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Text(
                'Veuillez scanner le bon code',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code;

        // Validation du code scanné
        if (result == 'EXPECTED_CODE') {
          // Remplacez 'EXPECTED_CODE' par le code attendu
          isCodeValid = true; // Code valide
        } else {
          isCodeValid = false; // Code invalide
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
