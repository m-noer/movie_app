import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';

part 'list_movie_model.g.dart';

@JsonSerializable(createToJson: false)
class ListMovieModel extends ListMovieEntity {
  const ListMovieModel({
    required super.page,
    required List<MovieModel> super.results,
    required super.totalPages,
    required super.totalResults,
  });

  factory ListMovieModel.fromJson(Map<String, dynamic> json) =>
      _$ListMovieModelFromJson(json);
}
