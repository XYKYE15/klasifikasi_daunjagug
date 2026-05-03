import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

import '../services/tflite_helper.dart';
import '../services/label_service.dart';
import '../widgets/image_preview.dart';
import '../widgets/result_card.dart';
import '../widgets/action_buttons.dart';
import '../widgets/loading_overlay.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final picker = ImagePicker();
  final helper = TFLiteHelper();

  File? imageFile;
  String result = "Belum ada hasil";
  double confidence = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    helper.loadModel();
  }

  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;

    setState(() => isLoading = true);

    final file = File(picked.path);
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);

    if (image == null) {
      setState(() => isLoading = false);
      return;
    }

    final prediction = helper.predict(image);

    setState(() {
      imageFile = file;
      result = prediction['label'];
      confidence = prediction['confidence'];
      isLoading = false;
    });
  }

  Color getColor(String color) {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  void reset() {
    setState(() {
      imageFile = null;
      result = "Belum ada hasil";
      confidence = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelData = LabelService.getLabel(result);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Deteksi Jagung"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [IconButton(onPressed: reset, icon: Icon(Icons.refresh))],
      ),

      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ImagePreview(imageFile: imageFile, isLoading: isLoading),
                      const SizedBox(height: 20),
                      ResultCard(
                        labelData: labelData,
                        confidence: confidence,
                        color: getColor(labelData['color']),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: ActionButtons(onPick: pickImage),
              ),
            ],
          ),

          LoadingOverlay(isLoading: isLoading),
        ],
      ),
    );
  }
}
