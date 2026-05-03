import 'dart:convert';
import 'package:flutter/services.dart';

class LabelService {
  static Map<String, dynamic> _data = {};

  static Future<void> load() async {
    final jsonString = await rootBundle.loadString('assets/data/labels.json');
    _data = json.decode(jsonString);
  }

  static Map<String, dynamic> getLabel(String key) {
    return _data[key.toLowerCase()] ??
        {"title": key, "description": "Tidak ada deskripsi", "color": "grey"};
  }
}
