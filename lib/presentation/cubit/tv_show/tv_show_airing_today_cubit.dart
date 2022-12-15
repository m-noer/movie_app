import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_airing_today_use_case.dart';

part 'tv_show_airing_today_state.dart';

class TvShowAiringTodayCubit extends Cubit<TvShowAiringTodayState> {
  TvShowAiringTodayCubit(this.getTvShowAiringTodayUseCase)
      : super(TvShowAiringTodayInitial());

  Future<void> getTvShowAiringToday(MovieQueryParameter params) async {
    emit(TvShowAiringTodayLoading());

    final failureOrSuccess = await getTvShowAiringTodayUseCase.call(params);

    failureOrSuccess.fold(
      (l) => emit(TvShowAiringTodayFailure(l.statusMessage)),
      (r) => emit(TvShowAiringTodaySuccess(r.results)),
    );
  }

  final GetTvShowAiringTodayUseCase getTvShowAiringTodayUseCase;
}
