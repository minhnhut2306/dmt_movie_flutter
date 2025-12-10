import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dmt_movie_flutter/gen_l10n/app_localizations.dart';
import '../../../../data/services/update_service.dart';
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

    return Scaffold(
      body: Consumer<MovieProvider>(
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
    );
  }

  Widget _buildError(String message, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: context.colorScheme.error),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadMovies,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.movie_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            l10n.noMovies,
            style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}