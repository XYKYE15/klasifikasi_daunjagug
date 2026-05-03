import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/label_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LabelService.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deteksi Jagung',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SplashScreen(),
    );
  }
}
