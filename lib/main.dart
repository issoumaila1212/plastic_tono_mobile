import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plastic_tono/screens/authentification/auth_sceen.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';
import 'package:plastic_tono/screens/scan/scan_screen.dart';
import 'package:plastic_tono/screens/authentification/register_screen.dart';
import 'package:plastic_tono/widgets/verificationcodeBox.dart';
import 'package:plastic_tono/screens/authentification/validation_screen.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCQxQUOeAdAsFt3lbQs9ZTvnc6lNA5zGiA",
        appId: "1:936871321591:android:7ceb7adaba1e6b48d418f2",
        messagingSenderId: "936871321591",
        projectId: "plastictono-e26cd",
        storageBucket: "plastictono-e26cd.appspot.com",
      ),
    );

    // Désactiver App Check
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(false);

    runApp(MyApp());
  } catch (e) {
    print('Firebase initialization error: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  Future<void> _fetchToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      token = await user.getIdToken();
      setState(() {});  // Mettre à jour l'interface utilisateur après avoir récupéré le token
      print('Token: $token');
    } else {
      print('User not logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RegisterScreen(), // Remplacez cela par la page que vous souhaitez afficher au démarrage
    );
  }
}

// Exemple de widget pour la page d'accueil
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: Icon(Icons.home),
        actions: const [
          Icon(Icons.notifications),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.deepGreen,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
