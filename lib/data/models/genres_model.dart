import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/domain/entities/entities.dart';

part 'genres_model.g.dart';

@JsonSerializable(createToJson: false)
class GenresModel extends GenresEntity {
  const GenresModel({required super.id, required super.name});

  factory GenresModel.fromJson(Map<String, dynamic> json) =>
      _$GenresModelFromJson(json);
}
