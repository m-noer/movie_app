import 'package:json_annotation/json_annotation.dart';

part 'failure.g.dart';

@JsonSerializable(createToJson: false)
class Failure {
  const Failure({
    this.statusMessage,
    this.statusCode,
  });

  factory Failure.fromJson(Map<String, dynamic> json) =>
      _$FailureFromJson(json);

  final String? statusMessage;
  final int? statusCode;
}
