import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    required this.title,
    this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String? title;
  final String? name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props {
    return [
      backdropPath,
      genreIds,
      id,
      originalLanguage,
      overview,
      popularity,
      posterPath,
      releaseDate,
      firstAirDate,
      title,
      name,
      voteAverage,
      voteCount,
    ];
  }
}
