import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';

import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_on_air_use_case.dart';

part 'tv_show_on_air_state.dart';

class TvShowOnAirCubit extends Cubit<TvShowOnAirState> {
  TvShowOnAirCubit(
    this.getTvShowOnAirUseCase,
  ) : super(TvShowOnAirInitial());

  Future<void> getTvShowOnAir(MovieQueryParameter params) async {
    emit(TvShowOnAirLoading());

    final failureOrSuccess = await getTvShowOnAirUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(TvShowOnAirFailure(l.statusMessage)),
      (r) => emit(TvShowOnAirSuccess(r.results)),
    );
  }

  final GetTvShowOnAirUseCase getTvShowOnAirUseCase;
}
