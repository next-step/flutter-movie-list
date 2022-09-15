import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieList {
  MovieList({
    this.dates,
    this.page = 0,
    List<Movie>? results,
    this.totalPages = 0,
    this.totalResults = 0,
  }) : results = results ?? [];

  Dates? dates;

  final int page;

  final List<Movie> results;

  final int totalPages;

  final int totalResults;

  factory MovieList.fromJson(Map<String, dynamic> json) => _$MovieListFromJson(json);
}

@JsonSerializable()
class Dates {
  final String maximum;
  final String minimum;

  Dates({
    this.maximum = '',
    this.minimum = '',
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Movie {
  Movie({
    this.adult = false,
    this.backdropPath = '',
    this.genreIds = const [],
    this.id = 0,
    this.originalLanguage = '',
    this.originalTitle = '',
    this.overview = '',
    this.popularity = 0,
    this.posterPath = '',
    this.releaseDate = '',
    this.title = '',
    this.video = false,
    this.voteAverage = 0.0,
    this.voteCount = 0,
  });

  final bool adult;

  final String backdropPath;

  final List<int> genreIds;

  final int id;

  final String originalLanguage;

  final String originalTitle;

  final String overview;

  final double popularity;

  final String posterPath;

  final String releaseDate;

  final String title;

  final bool video;

  final double voteAverage;

  final int voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailMovie {
  DetailMovie({
    required this.id,
    required this.title,
    this.adult = false,
    this.backdropPath = '',
    this.genres = const [],
    this.homepage,
    this.overview = '',
    this.releaseDate = '',
    this.voteAverage = 0.0,
    this.voteCount = 0,
    this.status = '',
  });

  final int id;

  final String title;

  final bool adult;

  final String backdropPath;

  final List<Genre> genres;

  final String? homepage;

  final String overview;

  final String releaseDate;

  final double voteAverage;

  final int voteCount;

  final String status;

  factory DetailMovie.fromJson(Map<String, dynamic> json) => _$DetailMovieFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;

  final String name;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}