class Movie {
  final String title;
  final String backDropPath;
  final String originalTitle;
  final String overView;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overView,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] ?? json["original_name"] ?? 'Unknown Title',
      backDropPath: json["backdrop_path"] ?? '',
      originalTitle: json["original_title"] ?? json["name"] ?? '',
      overView: json["overview"] ?? '',
      posterPath: json["poster_path"] ?? '',
      releaseDate: json["release_date"] ?? json["first_air_date"] ?? '',
      voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
    );
  }
}