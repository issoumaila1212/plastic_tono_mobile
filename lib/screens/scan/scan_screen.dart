import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import '../../components/default_btn.dart';
import '../../widgets/input.dart';
import '../../screens/scan/depotencours_screen.dart';
import 'package:plastic_tono/screens/scan/SessionService.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool showQrCode = true;
  bool isCodeValid = true;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;
  final TextEditingController kioskCodeController = TextEditingController();
  final SessionService _sessionService = SessionService();

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
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),
<<<<<<< Updated upstream
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DepotencoursScreen(), // Naviguer vers la page "Dépôt en cours"
                        ),
                      );
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
=======
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  AppImages.logo3,
                  height: 150,
                ),
              ),
              const SizedBox(height: 16),
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
                          showQrCode = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (showQrCode)
                Container(
                  height: 300,
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
                    const Text(
                      'Saisissez le code du kiosque',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    input(
                      phoneCtrl: kioskCodeController,
                      icon: Icons.code,
                      hintText: "---------",
                    ),
                    const SizedBox(height: 16),
                    defaultBtn(
                      text: 'Valider',
                      btnColor: AppColors.deepGreen,
                      onPress: () async {
                        try {
                          // Appel de la fonction pour démarrer la session
                          int id = await _sessionService
                              .demarrerSession(kioskCodeController.text);

                          // Naviguer vers l'écran suivant après le succès
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepotencoursScreen(
                                idSession: id,
                              ),
                            ),
                          );
                        } catch (e) {
                          // Gérer l'erreur si la session ne démarre pas correctement
                          print('Erreur lors de la création de la session: $e');
                          // Vous pouvez afficher un message d'erreur ici ou simplement le log
                        }
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 16),
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
                const Text(
                  'Veuillez scanner le bon code',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
>>>>>>> Stashed changes
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData.code;
      if (result == 'KIOSQUE124') {
        isCodeValid = true;
        await controller.pauseCamera();
        HapticFeedback.mediumImpact(); // Feedback haptique
        /*ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("code ok $result"),
          ),
        );*/// Appel de la fonction pour démarrer la session
        _sessionService
            .demarrerSession(scanData.code??'')
            .then((value) {
          // Naviguer vers l'écran suivant après le succès
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DepotencoursScreen(
                idSession: value,
              ),
            ),
          );
        }).catchError((e) {
          // Gérer l'erreur si la session ne démarre pas correctement
          print('Erreur lors de la création de la session: $e');
          // Vous pouvez afficher un message d'erreur ici ou simplement le log
        });


      } else {
        isCodeValid = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("code invalide"),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    kioskCodeController.dispose();
    super.dispose();
  }
}
