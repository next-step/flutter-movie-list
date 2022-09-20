import 'package:json_annotation/json_annotation.dart';

part 'movie_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieDetail {
  MovieDetail(
    this.backdropPath,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.overview,
  );

  final String backdropPath ;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final String overview;

  factory MovieDetail.fromJson(Map<String, dynamic> json) => _$MovieDetailFromJson(json);
}
