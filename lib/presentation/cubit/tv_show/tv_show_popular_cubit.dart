import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_popular_use_case.dart';

part 'tv_show_popular_state.dart';

class TvShowPopularCubit extends Cubit<TvShowPopularState> {
  TvShowPopularCubit(this.getTvShowPopularUseCase)
      : super(TvShowPopularInitial());

  Future<void> getTvShowPopular(MovieQueryParameter params) async {
    emit(TvShowPopularLoading());

    final failureOrSuccess = await getTvShowPopularUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(TvShowPopularFailure(l.statusMessage)),
      (r) => emit(TvShowPopularSuccess(r.results)),
    );
  }

  final GetTvShowPopularUseCase getTvShowPopularUseCase;
}
