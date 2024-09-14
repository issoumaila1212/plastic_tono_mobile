import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/scan/SessionService.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/screens/scan/findepot_screen.dart';

class DepotencoursScreen extends StatefulWidget {
  final int idSession;
  const DepotencoursScreen ({ super.key, required this.idSession });


  @override
  _DepotencoursScreenState createState() => _DepotencoursScreenState();
}

class _DepotencoursScreenState extends State<DepotencoursScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  int _start = 70; // 1 minute et 10 secondes (en secondes)
  final TextEditingController finController = TextEditingController();
  final SessionService _sessionService = SessionService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Durée pour un tour complet
      vsync: this,
    )..repeat(); // Répéter l'animation en boucle

    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    finController.dispose();
    super.dispose();
  }
  int poids = 0;

  @override
  Widget build(BuildContext context) {
    int idSession=widget.idSession;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: Text(
          'Dépôt en cours',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(); // Retour à l'écran précédent
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: _controller,
                    child: Icon(
                      Icons.hourglass_top,
                      color: Colors.orange,
                      size: 300,
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(

                    onPressed: () async {
                      try {
                        // Clôturer la session sans avoir besoin de passer un ID manuellement
                        String result = await _sessionService.cloturerSession(idSession);

                        // Afficher le message de succès
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result),
                          ),
                        );

                        // Naviguer vers l'écran suivant après la clôture de la session
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinDepotScreen(idSession: idSession),
                          ),
                        );
                      } catch (e) {
                        // Afficher un message d'erreur si quelque chose tourne mal
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Erreur lors de la clôture de la session: $e"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Fin',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 150,
            child: TimerCircleDisplay(
              duration: _start,
              progress: 1 - (_start / 70),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerCircleDisplay extends StatelessWidget {
  final int duration;
  final double progress;

  const TimerCircleDisplay({
    Key? key,
    required this.duration,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepGreen),
          ),
        ),
        Text(
          "${duration ~/ 60}:${(duration % 60).toString().padLeft(2, '0')}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.deepGreen,
          ),
        ),
      ],
    );
  }
}
