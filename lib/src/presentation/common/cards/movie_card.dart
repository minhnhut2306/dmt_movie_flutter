import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../data/models/movie.dart';
import '../../../core/router/route_names.dart';
import '../../../core/utils/extensions.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      title: Text(movie.title),
      subtitle: Text(l10n.seeDetails),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        context.pushNamed(RouteNames.movieDetail, arguments: movie);
      },
    );
  }
}