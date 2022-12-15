import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/domain/entities/entities.dart';

part 'movie_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieModel extends MovieEntity {
  const MovieModel({
    super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalLanguage,
    required super.overview,
    required super.popularity,
    super.posterPath,
    super.releaseDate,
    super.firstAirDate,
    required super.title,
    required super.name,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
