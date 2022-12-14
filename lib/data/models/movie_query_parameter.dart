import 'package:json_annotation/json_annotation.dart';

part 'movie_query_parameter.g.dart';

@JsonSerializable(createFactory: false)
class MovieQueryParameter {
  MovieQueryParameter({
    this.language,
    this.page,
    this.region,
  });

  final String? language;
  final int? page;
  final String? region;

  Map<String, dynamic> toJson() => _$MovieQueryParameterToJson(this);
}
