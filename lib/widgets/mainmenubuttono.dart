import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';

class MainMenuButtono extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color
      iconColor; // Nouvelle propriété ajoutée pour la couleur de l'icône

  final VoidCallback onPressed;

  const MainMenuButtono({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  _MainMenuButtonState createState() => _MainMenuButtonState();
}

class _MainMenuButtonState extends State<MainMenuButtono> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Couleur de fond du cercle
              ),
              child: Icon(
                widget.icon,
                color: widget
                    .iconColor, // Utilisez iconColor pour la couleur de l'icône
                size: 40,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
