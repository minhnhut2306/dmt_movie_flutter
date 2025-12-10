import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/presentation/providers/settings_provider.dart';
import 'src/presentation/providers/movie_provider.dart';
import 'src/data/repositories/movie_repository.dart';
import 'src/data/services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = SettingsProvider();
  await settings.load();

  final apiService = ApiService();
  final movieRepository = MovieRepository(apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        ChangeNotifierProvider(
          create: (_) => MovieProvider(movieRepository),
        ),
      ],
      child: const MovieApp(),
    ),
  );
}