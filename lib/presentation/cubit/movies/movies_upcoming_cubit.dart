import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_upcoming_use_case.dart';

part 'movies_upcoming_state.dart';

class MoviesUpcomingCubit extends Cubit<MoviesUpcomingState> {
  MoviesUpcomingCubit(this.getMoviesUpcomingUseCase)
      : super(MoviesUpcomingInitial());

  Future<void> getMoviesUpcoming(MovieQueryParameter params) async {
    emit(MoviesUpcomingLoading());

    final failureOrSuccess = await getMoviesUpcomingUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(MoviesUpcomingFailure(l.statusMessage)),
      (r) => emit(MoviesUpcomingSuccess(r.results)),
    );
  }

  final GetMoviesUpcomingUseCase getMoviesUpcomingUseCase;
}
