import '../models/movie.dart';

class ApiService {
  Future<List<Movie>> fetchMovies() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Movie(id: 1, title: "Phim nhật bản"),
      Movie(id: 2, title: "Phim hàn quốc"),
      Movie(id: 3, title: "Phim trung quốc"),
      Movie(id: 4, title: "Phim việt nam"),
      Movie(id: 5, title: "Phim mỹ"),
      Movie(id: 6, title: "Phim thái lan"),
      Movie(id: 7, title: "Phim ấn độ"),
      Movie(id: 8, title: "Phim anh quốc"),
    ];
  }
}
