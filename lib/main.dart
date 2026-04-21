import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env for EmailJS credentials
  await dotenv.load(fileName: '.env');

  runApp(PortfolioApp());
}
