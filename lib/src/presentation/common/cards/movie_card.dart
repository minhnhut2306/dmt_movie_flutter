import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../data/models/movie.dart';
import '../../../core/router/route_names.dart';
import '../../../core/responsive.dart';
import '../../../core/utils/extensions.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: Responsive.spacingM(context),
        vertical: Responsive.spacingS(context),
      ),
      title: Text(
        movie.title,
        style: TextStyle(
          fontSize: Responsive.bodyFontSize(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        'seeDetails'.tr(),
        style: TextStyle(
          fontSize: Responsive.captionFontSize(context),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward,
        size: Responsive.size24(context),
      ),
      onTap: () {
        context.pushNamed(RouteNames.movieDetail, arguments: movie);
      },
    );
  }
}