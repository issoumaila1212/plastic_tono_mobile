import 'package:flutter/material.dart';
import 'package:plastic_tono/themes/color/app_colors.dart';

class HistoriqueDepotListView extends StatelessWidget {
  final List<Map<String, dynamic>> depots;

  const HistoriqueDepotListView({
    Key? key,
    required this.depots,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return ListView.builder(
      itemCount: depots.length,
      itemBuilder: (context, index) {
        final depot = depots[index];
        double v=depot['points'] as double;

        String pt=v.toStringAsFixed(2); // '2.35'


        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      depot['date'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      depot['kiosque'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Poids : ${depot['poids']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${pt} points' // '2.35'
                  ,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepGreen,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
