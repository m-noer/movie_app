import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_now_playing_use_case.dart';
import 'package:movie_app/presentation/cubit/movies/movies_now_playing_cubit.dart';

import '../../../domain/use_cases/movies/get_movies_now_playing_use_case_test.dart';

class MockGetMoviesNowPlayingUseCase extends Mock
    implements GetMoviesNowPlayingUseCase {}

void main() {
  final mockGetMoviesNowPlayingUseCase = MockGetMoviesNowPlayingUseCase();
  late MoviesNowPlayingCubit cubit;

  setUp(() async {
    cubit = MoviesNowPlayingCubit(mockGetMoviesNowPlayingUseCase);
  });

  group('Get Movies Now Playing', () {
    blocTest<MoviesNowPlayingCubit, MoviesNowPlayingState>(
      'should emit [MoviesNowPlayingLoading, MoviesNowPlayingSuccess]',
      build: () {
        when(() => mockGetMoviesNowPlayingUseCase.call(movieQuery)).thenAnswer(
          (realInvocation) => Future.value(const Right(listMovieEntity)),
        );
        return cubit;
      },
      act: (cubit) => cubit.getMoviesNowPlaying(movieQuery),
      expect: () => [
        MoviesNowPlayingLoading(),
        MoviesNowPlayingSuccess(listMovieEntity.results),
      ],
    );

    blocTest<MoviesNowPlayingCubit, MoviesNowPlayingState>(
      'should emit [MoviesNowPlayingLoading, MoviesNowPlayingFailure]',
      build: () {
        when(() => mockGetMoviesNowPlayingUseCase.call(movieQuery)).thenAnswer(
          (realInvocation) =>
              Future.value(const Left(Failure(statusMessage: 'error'))),
        );
        return cubit;
      },
      act: (cubit) => cubit.getMoviesNowPlaying(movieQuery),
      expect: () => [
        MoviesNowPlayingLoading(),
        const MoviesNowPlayingFailure('error'),
      ],
    );
  });
}
