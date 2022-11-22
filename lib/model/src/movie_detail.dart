import 'package:json_annotation/json_annotation.dart';

part 'movie_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieDetail {
  MovieDetail({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final Object? belongsToCollection;
  final int budget;
  final List<Genres> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String? overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompanies> productionCompanies;
  final List<ProductionCountries> productionCountries;
  final String releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguages> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genres {
  Genres({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanies {
  ProductionCompanies({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountries {
  ProductionCountries({
    required this.iso_3166_1,
    required this.name,
  });

  final String iso_3166_1;
  final String name;

  factory ProductionCountries.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguages {
  SpokenLanguages({
    required this.iso_639_1,
    required this.name,
  });

  final String iso_639_1;
  final String name;

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesFromJson(json);
}
