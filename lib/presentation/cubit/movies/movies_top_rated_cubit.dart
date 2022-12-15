import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_top_rated_use_case.dart';

part 'movies_top_rated_state.dart';

class MoviesTopRatedCubit extends Cubit<MoviesTopRatedState> {
  MoviesTopRatedCubit(this.getMoviesTopRatedUseCase)
      : super(MoviesTopRatedInitial());

  Future<void> getMoviesTopRated(MovieQueryParameter params) async {
    emit(MoviesTopRatedLoading());

    final failureOrSuccess = await getMoviesTopRatedUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(MoviesTopRatedFailure(l.statusMessage)),
      (r) => emit(MoviesTopRatedSuccess(r.results)),
    );
  }

  final GetMoviesTopRatedUseCase getMoviesTopRatedUseCase;
}
