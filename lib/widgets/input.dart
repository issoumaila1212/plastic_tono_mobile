import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';

class input extends StatefulWidget {
  input({
    super.key,
    required this.phoneCtrl,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.isPhone = false,
    this.isName = false,
    this.isEmail = false,
  });

  final TextEditingController phoneCtrl;
  final String hintText;
  final IconData? icon;
  final bool isPassword;

  final bool isPhone;
  final bool isName;
  final bool isEmail;


  @override
  State<input> createState() => _inputState();
}

class _inputState extends State<input> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  // methode pour connaitre le type de champ
  TextInputType _getKeyboardType() {
    if (widget.isPhone) {
      return TextInputType.phone;
    } else if (widget.isEmail) {
      return TextInputType.emailAddress;
    } else if (widget.isName) {
      return TextInputType.name;
    } else if (widget.isPassword) {
      return TextInputType.text;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black54,
      child: TextFormField(
        controller: widget.phoneCtrl,
        obscureText: obscureText,
        keyboardType: _getKeyboardType(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: AppColors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.white),
          ),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Colors.grey.shade400,
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
