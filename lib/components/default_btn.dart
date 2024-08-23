import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';

class defaultBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;
  final Color btnColor;

  const defaultBtn({
    Key? key,
    required this.text,
    this.onPress,
    this.btnColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: btnColor,
          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontStyle: FontStyle.normal,
          ),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
