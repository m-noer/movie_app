import 'package:equatable/equatable.dart';

class GenresEntity extends Equatable {
  const GenresEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
