// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_tv_show_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailTvShowModel _$DetailTvShowModelFromJson(Map<String, dynamic> json) =>
    DetailTvShowModel(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] as String,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenresModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String,
      id: json['id'] as int,
      inProduction: json['in_production'] as bool,
      languages:
          (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      lastAirDate: json['last_air_date'] as String,
      name: json['name'] as String,
      numberOfEpisodes: json['number_of_episodes'] as int,
      numberOfSeasons: json['number_of_seasons'] as int,
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      status: json['status'] as String,
      tagline: json['tagline'] as String,
      type: json['type'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
