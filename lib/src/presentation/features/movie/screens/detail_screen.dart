import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../data/models/movie.dart';
import '../../../../core/responsive.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final movie = ModalRoute.of(context)!.settings.arguments as Movie?;
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie?.title ?? l10n.movieDetails,
          style: TextStyle(fontSize: Responsive.headingFontSize(context)),
        ),
        toolbarHeight: Responsive.appBarHeight(context),
      ),
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: Center(
            child: Text(
              l10n.movieId(movie?.id.toString() ?? 'N/A'),
              style: TextStyle(fontSize: Responsive.bodyFontSize(context)),
            ),
          ),
        ),
      ),
    );
  }
}
