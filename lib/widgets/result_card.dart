import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> labelData;
  final double confidence;
  final Color color;

  const ResultCard({
    required this.labelData,
    required this.confidence,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text("Hasil Deteksi", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),

          Text(
            labelData['title'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: confidence,
            backgroundColor: Colors.white24,
            color: Colors.white,
          ),

          const SizedBox(height: 10),

          Text(
            "${(confidence * 100).toStringAsFixed(2)}%",
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 10),

          Text(
            labelData['description'],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
