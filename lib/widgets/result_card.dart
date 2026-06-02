import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final Map<String, dynamic> labelData;
  final double confidence;
  final Color color;

  const ResultCard({
    required this.labelData,
    required this.confidence,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<dynamic> prevention = labelData['prevention'] ?? [];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Hasil Deteksi",
              style: TextStyle(color: Colors.white70),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              labelData['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: confidence,
            backgroundColor: Colors.white24,
            color: Colors.white,
          ),

          const SizedBox(height: 10),

          Center(
            child: Text(
              "${(confidence * 100).toStringAsFixed(2)}%",
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            labelData['description'],
            textAlign: TextAlign.justify,
            style: const TextStyle(color: Colors.white),
          ),

          if (prevention.isNotEmpty) ...[
            const SizedBox(height: 16),

            const Text(
              "Pencegahan:",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            ...prevention.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "• ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
