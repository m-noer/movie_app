import 'package:equatable/equatable.dart';

import 'package:movie_app/domain/entities/entities.dart';

class ListMovieEntity extends Equatable {
  const ListMovieEntity({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieEntity> results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object> get props => [page, results, totalPages, totalResults];
}
