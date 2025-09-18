import 'package:dmt_movie_flutter/src/utils/update_checker.dart';
import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';


import '../services/api_service.dart';
import '../widgets/movie_card.dart';
import '../widgets/loading_spinner.dart';
import '../models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> movies;

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkForUpdate(context);
  });
  movies = ApiService().fetchMovies();
}


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings),
            tooltip: l10n.openSettings,
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSpinner();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          }
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Center(child: Text(l10n.noMovies));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, i) => MovieCard(movie: list[i]),
          );
        },
      ),
    );
  }
}
