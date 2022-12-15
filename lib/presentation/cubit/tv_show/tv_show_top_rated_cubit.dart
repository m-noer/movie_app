import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_top_rated_use_case.dart';

part 'tv_show_top_rated_state.dart';

class TvShowTopRatedCubit extends Cubit<TvShowTopRatedState> {
  TvShowTopRatedCubit(this.getTvShowTopRatedUseCase)
      : super(TvShowTopRatedInitial());

  Future<void> getTvShowTopRated(MovieQueryParameter params) async {
    emit(TvShowTopRatedLoading());

    final failureOrSuccess = await getTvShowTopRatedUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(TvShowTopRatedFailure(l.statusMessage)),
      (r) => emit(TvShowTopRatedSuccess(r.results)),
    );
  }

  final GetTvShowTopRatedUseCase getTvShowTopRatedUseCase;
}
