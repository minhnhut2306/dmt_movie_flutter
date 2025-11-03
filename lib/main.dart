import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = SettingsProvider();
  await settings.load(); 

  runApp(
    ChangeNotifierProvider.value(
      value: settings,
      child: const MovieApp(),
    ),
  );
}
