import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

part 'detail_tv_show_model.g.dart';

@JsonSerializable(createToJson: false)
class DetailTvShowModel extends DetailTvShowEntity {
  const DetailTvShowModel({
    required super.adult,
    required super.backdropPath,
    required super.firstAirDate,
    required List<GenresModel> super.genres,
    required super.homepage,
    required super.id,
    required super.inProduction,
    required super.languages,
    required super.lastAirDate,
    required super.name,
    required super.numberOfEpisodes,
    required super.numberOfSeasons,
    required super.originalLanguage,
    required super.originalName,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.status,
    required super.tagline,
    required super.type,
    required super.voteAverage,
    required super.voteCount,
  });

  factory DetailTvShowModel.fromJson(Map<String, dynamic> json) =>
      _$DetailTvShowModelFromJson(json);
}
