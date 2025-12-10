import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../data/services/update_service.dart';
import '../../../../core/responsive.dart';
import '../../../../core/utils/extensions.dart';
import '../../../providers/movie_provider.dart';
import '../../../common/loading/loading_spinner.dart';
import '../widgets/movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkForUpdate(context);
      _loadMovies();
    });
  }

  void _loadMovies() {
    context.read<MovieProvider>().loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final maxWidth = Responsive.maxContentWidth(context);

    return Scaffold(
      body: Center(
        child: Container(
          width: maxWidth == double.infinity ? double.infinity : maxWidth,
          child: Consumer<MovieProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const LoadingSpinner();
              }

              if (provider.hasError) {
                return _buildError(provider.errorMessage!, l10n);
              }

              if (provider.isEmpty) {
                return _buildEmpty(l10n);
              }

              return MovieList(movies: provider.movies);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: Responsive.horizontalPadding(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: Responsive.size64(context),
              color: context.colorScheme.error,
            ),
            SizedBox(height: Responsive.spacingM(context)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: Responsive.bodyFontSize(context),
              ),
            ),
            SizedBox(height: Responsive.spacingL(context)),
            ElevatedButton.icon(
              onPressed: _loadMovies,
              icon: Icon(Icons.refresh, size: Responsive.size20(context)),
              label: Text(
                l10n.retry,
                style: TextStyle(fontSize: Responsive.bodyFontSize(context)),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.spacingL(context),
                  vertical: Responsive.spacingM(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.movie_outlined,
            size: Responsive.size64(context),
            color: Colors.grey,
          ),
          SizedBox(height: Responsive.spacingM(context)),
          Text(
            l10n.noMovies,
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
              fontSize: Responsive.bodyFontSize(context),
            ),
          ),
        ],
      ),
    );
  }
}
