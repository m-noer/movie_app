// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMovieModel _$DetailMovieModelFromJson(Map<String, dynamic> json) =>
    DetailMovieModel(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      budget: json['budget'] as int,
      genres: (json['genres'] as List<dynamic>)
          .map((e) => GenresModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>)
          .map((e) =>
              ProductionCompaniesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      releaseDate: json['release_date'] as String,
      revenue: json['revenue'] as int,
      runtime: json['runtime'] as int,
      status: json['status'] as String,
      tagline: json['tagline'] as String?,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
