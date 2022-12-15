import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';

import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_now_playing_use_case.dart';

part 'movies_now_playing_state.dart';

class MoviesNowPlayingCubit extends Cubit<MoviesNowPlayingState> {
  MoviesNowPlayingCubit(
    this.getMoviesNowPlayingUseCase,
  ) : super(MoviesNowPlayingInitial());

  Future<void> getMoviesNowPlaying(MovieQueryParameter params) async {
    emit(MoviesNowPlayingLoading());

    final failureOrSuccess = await getMoviesNowPlayingUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(MoviesNowPlayingFailure(l.statusMessage)),
      (r) => emit(MoviesNowPlayingSuccess(r.results)),
    );
  }

  final GetMoviesNowPlayingUseCase getMoviesNowPlayingUseCase;
}
