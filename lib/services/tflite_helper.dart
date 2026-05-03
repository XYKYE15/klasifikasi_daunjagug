import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class TFLiteHelper {
  late Interpreter _interpreter;
  bool _isLoaded = false;

  final List<String> labels = ['bercak', 'sehat', 'hawar', 'karat'];

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/model_jagungfix.tflite');
    _isLoaded = true;
  }

  Float32List preprocess(img.Image image) {
    image = img.bakeOrientation(image);
    img.Image resized = img.copyResize(image, width: 224, height: 224);

    var input = Float32List(1 * 224 * 224 * 3);

    int index = 0;

    for (int y = 0; y < 224; y++) {
      for (int x = 0; x < 224; x++) {
        final pixel = resized.getPixel(x, y);

        input[index++] = pixel.r.toDouble();
        input[index++] = pixel.g.toDouble();
        input[index++] = pixel.b.toDouble();
      }
    }

    return input;
  }

  Map<String, dynamic> predict(img.Image image) {
    if (!_isLoaded) {
      throw Exception("Model belum di-load");
    }

    var input = preprocess(image);

    var output = List.generate(1, (_) => List.filled(4, 0.0));

    _interpreter.run(input.reshape([1, 224, 224, 3]), output);

    int index = 0;
    double max = output[0][0];

    for (int i = 1; i < output[0].length; i++) {
      if (output[0][i] > max) {
        max = output[0][i];
        index = i;
      }
    }

    return {"label": labels[index], "confidence": max};
  }

  void close() {
    _interpreter.close();
  }
}
