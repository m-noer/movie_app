// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMovieModel _$ListMovieModelFromJson(Map<String, dynamic> json) =>
    ListMovieModel(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
