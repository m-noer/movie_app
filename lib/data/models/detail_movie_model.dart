import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

part 'detail_movie_model.g.dart';

@JsonSerializable(createToJson: false)
class DetailMovieModel extends DetailMovieEntity {
  const DetailMovieModel({
    required super.adult,
    required super.backdropPath,
    required super.budget,
    required List<GenresModel> super.genres,
    required super.homepage,
    required super.id,
    required super.imdbId,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required List<ProductionCompaniesModel> super.productionCompanies,
    required super.releaseDate,
    required super.revenue,
    required super.runtime,
    required super.status,
    required super.tagline,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
  });

  factory DetailMovieModel.fromJson(Map<String, dynamic> json) =>
      _$DetailMovieModelFromJson(json);
}
