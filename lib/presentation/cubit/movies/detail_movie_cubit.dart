import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/movies/get_detail_movie_use_case.dart';

part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  DetailMovieCubit(
    this.getDetailMovieUseCase,
  ) : super(DetailMovieInitial());

  Future<void> getDetailMovie(int id) async {
    emit(DetailMovieLoading());

    final failureOrSuccess = await getDetailMovieUseCase.call(id);

    failureOrSuccess.fold(
      (l) => emit(DetailMovieFailure(l.statusMessage)),
      (r) => emit(DetailMovieSuccess(r)),
    );
  }

  final GetDetailMovieUseCase getDetailMovieUseCase;
}
