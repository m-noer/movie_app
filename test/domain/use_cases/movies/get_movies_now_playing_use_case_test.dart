import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_now_playing_use_case.dart';

final movieQuery = MovieQueryParameter(
  page: 1,
  language: 'id',
  region: 'id',
);

const listMovieEntity = ListMovieEntity(
  page: 1,
  totalPages: 1,
  totalResults: 1,
  results: [
    MovieEntity(
      genreIds: [1],
      id: 1,
      originalLanguage: 'originalLanguage',
      overview: 'overview',
      popularity: 9,
      title: 'title',
      voteAverage: 9,
      voteCount: 22,
    ),
  ],
);

class MockMovieRepository extends Mock implements MoviesRepository {}

void main() {
  group('Get Movies Now playing use-case test', () {
    final mockMovieRepository = MockMovieRepository();

    final usecase = GetMoviesNowPlayingUseCase(mockMovieRepository);

    test('Should get ListMovieEntity', () async {
      // arrange
      when(() => mockMovieRepository.getMoviesNowPlaying(movieQuery))
          .thenAnswer(
        (invocation) => Future.value(const Right(listMovieEntity)),
      );

      // act
      final result = await usecase.call(movieQuery);

      // assert
      expect(result, const Right<dynamic, ListMovieEntity>(listMovieEntity));
    });

    test('Should fail', () async {
      // Arrange
      when(() => mockMovieRepository.getMoviesNowPlaying(movieQuery))
          .thenAnswer(
        (invocation) => Future.value(
          const Left(Failure(statusCode: 400, statusMessage: 'not found')),
        ),
      );

      // Act
      final result = await usecase.call(movieQuery);

      // Assert
      expect(
        result,
        const Left<dynamic, Failure>(
          Failure(statusCode: 400, statusMessage: 'not found'),
        ),
      );
    });
  });
}
