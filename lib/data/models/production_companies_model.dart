import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/domain/entities/entities.dart';

part 'production_companies_model.g.dart';

@JsonSerializable(createToJson: false)
class ProductionCompaniesModel extends ProductionCompaniesEntity {
  const ProductionCompaniesModel({
    required super.id,
    required super.logoPath,
    required super.name,
    required super.originCountry,
  });

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesModelFromJson(json);
}
