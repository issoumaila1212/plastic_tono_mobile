import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';
import 'package:plastic_tono/screens/home/home_screen.dart';

class LocaliserKiosquesScreen extends StatefulWidget {
  const LocaliserKiosquesScreen({super.key});

  @override
  _LocaliserKiosquesScreenState createState() =>
      _LocaliserKiosquesScreenState();
}

class _LocaliserKiosquesScreenState extends State<LocaliserKiosquesScreen> {
  late GoogleMapController mapController;

  final LatLng _center =
      const LatLng(12.6392, -8.0029); // Coordonnées de Bamako

  final Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('Kiosque1'),
      position: LatLng(12.6392, -8.0029), // Coordonnées d'un kiosque à Bamako
      infoWindow: InfoWindow(
        title: 'Kiosque plein',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed), // Icône rouge pour le kiosque plein
    ),
    Marker(
      markerId: MarkerId('Kiosque2'),
      position:
          LatLng(12.6471, -8.0000), // Coordonnées d'un autre kiosque à Bamako
      infoWindow: InfoWindow(
        title: 'Kiosque non plein',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen), // Icône verte pour le kiosque non plein
    ),
    // Ajoutez d'autres marqueurs de kiosque ici
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepGreen,
        title: const Text('Localisation des kiosques',
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            ); // Retour à l'écran précédent
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom:
                    14.0, // Zoom ajusté pour une vue plus rapprochée de Bamako
              ),
              markers: _markers,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Légendes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.delete, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text('= Kiosque non plein',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    const SizedBox(width: 8),
                    const Text('= Kiosque plein',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
