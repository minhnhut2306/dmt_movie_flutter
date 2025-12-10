import 'package:flutter/material.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../core/responsive.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxWidth = Responsive.maxContentWidth(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.searchTitle,
          style: TextStyle(
            fontSize: Responsive.headingFontSize(context),
          ),
        ),
        toolbarHeight: Responsive.appBarHeight(context),
      ),
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: Center(
            child: Text(
              l10n.searchContent,
              style: TextStyle(
                fontSize: Responsive.bodyFontSize(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}