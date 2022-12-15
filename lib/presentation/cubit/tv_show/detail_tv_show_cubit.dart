import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_detail_tv_show_use_case.dart';

part 'detail_tv_show_state.dart';

class DetailTvShowCubit extends Cubit<DetailTvShowState> {
  DetailTvShowCubit(
    this.getDetailTvShowUseCase,
  ) : super(DetailTvShowInitial());

  Future<void> getDetailTvShow(int id) async {
    emit(DetailTvShowLoading());

    final failureOrSuccess = await getDetailTvShowUseCase.call(id);

    failureOrSuccess.fold(
      (l) => emit(DetailTvShowFailure(l.statusMessage)),
      (r) => emit(DetailTvShowSuccess(r)),
    );
  }

  final GetDetailTvShowUseCase getDetailTvShowUseCase;
}
