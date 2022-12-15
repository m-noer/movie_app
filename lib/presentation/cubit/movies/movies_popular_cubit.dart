import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_popular_use_case.dart';

part 'movies_popular_state.dart';

class MoviesPopularCubit extends Cubit<MoviesPopularState> {
  MoviesPopularCubit(this.getMoviesPopularUseCase)
      : super(MoviesPopularInitial());

  Future<void> getMoviesPopular(MovieQueryParameter params) async {
    emit(MoviesPopularLoading());

    final failureOrSuccess = await getMoviesPopularUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(MoviesPopularFailure(l.statusMessage)),
      (r) => emit(MoviesPopularSuccess(r.results)),
    );
  }

  final GetMoviesPopularUseCase getMoviesPopularUseCase;
}
