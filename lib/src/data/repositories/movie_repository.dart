import '../../core/utils/result.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieRepository {
  final ApiService _apiService;

  MovieRepository(this._apiService);

  Future<Result<List<Movie>>> getMovies() async {
    try {
      final movies = await _apiService.fetchMovies();
      return Success(movies);
    } catch (e) {
      return Failure('Không thể tải danh sách phim: ${e.toString()}');
    }
  }

  Future<Result<Movie>> getMovieById(int id) async {
    try {
      final movies = await _apiService.fetchMovies();
      final movie = movies.firstWhere(
        (m) => m.id == id,
        orElse: () => throw Exception('Không tìm thấy phim'),
      );
      return Success(movie);
    } catch (e) {
      return Failure('Không thể tải thông tin phim: ${e.toString()}');
    }
  }
}