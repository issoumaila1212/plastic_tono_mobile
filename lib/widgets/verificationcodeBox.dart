import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';

class VerificationCodeBox extends StatefulWidget {
  final TextEditingController controller;
  final bool autoFocus;

  const VerificationCodeBox({
    Key? key,
    required this.controller,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  _VerificationCodeBoxState createState() => _VerificationCodeBoxState();
}

class _VerificationCodeBoxState extends State<VerificationCodeBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
          controller: widget.controller,
          autofocus: widget.autoFocus,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.deepGreen),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.deepGreen),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.deepGreen),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus(); // Passe au champ suivant
            }
          }),
    );
  }
}
