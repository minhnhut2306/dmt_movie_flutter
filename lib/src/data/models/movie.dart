class Movie {
  final int id;
  final String title;

  Movie({
    required this.id,
    required this.title,
  });

  Movie copyWith({
    int? id,
    String? title,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Movie && other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() => 'Movie(id: $id, title: $title)';
}