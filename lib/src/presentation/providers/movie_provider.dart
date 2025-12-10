import 'package:dmt_movie_flutter/src/core/utils/result.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/movie.dart';
import '../../data/repositories/movie_repository.dart';

enum MovieState { initial, loading, loaded, error }

class MovieProvider extends ChangeNotifier {
  final MovieRepository _repository;

  MovieProvider(this._repository);

  MovieState _state = MovieState.initial;
  List<Movie> _movies = [];
  String? _errorMessage;

  MovieState get state => _state;
  List<Movie> get movies => _movies;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == MovieState.loading;
  bool get hasError => _state == MovieState.error;
  bool get isEmpty => _movies.isEmpty && _state == MovieState.loaded;

  Future<void> loadMovies() async {
    _state = MovieState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _repository.getMovies();

    result.when(
      success: (movies) {
        _movies = movies;
        _state = MovieState.loaded;
      },
      failure: (message) {
        _errorMessage = message;
        _state = MovieState.error;
      },
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    await loadMovies();
  }
}