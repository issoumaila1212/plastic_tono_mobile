import 'package:flutter/material.dart';

class PointsTotalWidget extends StatefulWidget {
  final int points;

  const PointsTotalWidget({
    Key? key,
    required this.points,
  }) : super(key: key);

  @override
  _PointsTotalWidgetState createState() => _PointsTotalWidgetState();
}

class _PointsTotalWidgetState extends State<PointsTotalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Points total",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "${widget.points} pts",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.remove_red_eye, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              const Text(
                "voir plus",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
