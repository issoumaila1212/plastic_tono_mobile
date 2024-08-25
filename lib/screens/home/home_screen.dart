import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/Historique/transactionhistory_screen.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/themes/images/app_images.dart';
import 'package:plastic_tono/widgets/mainmenubutton.dart';
import 'package:plastic_tono/widgets/mainmenubuttono.dart';
import 'package:plastic_tono/screens/scan/scan_screen.dart';
import 'package:plastic_tono/screens/Historique/historiquedepot_screen.dart';
import 'package:plastic_tono/screens/point/point_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(
              Icons.notifications,
              color: AppColors.orange,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.account_circle, color: Colors.orange),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.deepGreen,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Center(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.logo1,
                      height: 30,
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Image.asset(
                  AppImages.logo2,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 5,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Points: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          "1200 pts",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 20,
                childAspectRatio: 1.1,
                children: [
                  MainMenuButton(
                    label: 'Commencer un dépôt',
                    icon: Icons.center_focus_weak,
                    color: AppColors.deepGreen,
                    iconColor: AppColors.deepGreen,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanScreen(),
                        ),
                      );
                    },
                  ),
                  MainMenuButtono(
                    label: 'Historique des dépôts',
                    icon: Icons.history,
                    color: Colors.orange,
                    iconColor: AppColors.deepGreen,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoriqueDepotScreen(),
                        ),
                      );
                    },
                  ),
                  MainMenuButtono(
                    label: 'Voir mes points',
                    icon: Icons.monetization_on,
                    color: Colors.orange,
                    iconColor: AppColors.deepGreen,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PointsScreen(),
                        ),
                      );
                    },
                  ),
                  MainMenuButton(
                    label: 'Historique des transactions',
                    icon: Icons.archive,
                    color: AppColors.deepGreen,
                    iconColor: AppColors.deepGreen,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TransactionHistoryScreen()));
                    },
                  ),
                  MainMenuButton(
                    label: 'Localiser nos kiosques',
                    icon: Icons.location_on,
                    color: AppColors.deepGreen,
                    iconColor: AppColors.deepGreen,
                    onPressed: () {},
                  ),
                  MainMenuButtono(
                    label: 'Suggestions',
                    icon: Icons.feedback,
                    color: Colors.orange,
                    iconColor: AppColors.deepGreen,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            //Grid view pour les bouttons
          ],
        ),
      ),
    );
  }
}
