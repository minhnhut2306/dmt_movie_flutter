import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../data/models/movie.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final movie = ModalRoute.of(context)!.settings.arguments as Movie?;
    
    return Scaffold(
      appBar: AppBar(title: Text(movie?.title ?? l10n.movieDetails)),
      body: Center(
        child: Text(l10n.movieId(movie?.id.toString() ?? 'N/A')),
      ),
    );
  }
}