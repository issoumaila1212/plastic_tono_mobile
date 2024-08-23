import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';

import '../../components/default_btn.dart';
import '../../widgets/input.dart';

class AuthSceen extends StatefulWidget {
  const AuthSceen({super.key});

  @override
  State<AuthSceen> createState() => _AuthSceenState();
}

class _AuthSceenState extends State<AuthSceen> {
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Image.asset(
                    AppImages.logo,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.deepGreen,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        input(
                          phoneCtrl: phoneCtrl,
                          icon: Icons.phone,
                          hintText: "Numero de telephone",
                        ),
                        input(
                          phoneCtrl: passwordCtrl,
                          icon: Icons.key,
                          hintText: "Mot de passe",
                          isPassword: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Se souvenir de moi",
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Mot de passe Oublié",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                        //Btn
                        const SizedBox(
                          height: 10,
                        ),
                        defaultBtn(
                          text: "Connexion",
                          btnColor: AppColors.white,
                        ),

                        //
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text.rich(
                            TextSpan(
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                                text: "Vous n'avez pas de compte ",
                                children: [
                                  TextSpan(
                                    text: "Creer un compte".toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  )
                                ]),
                          ),
                        )
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
