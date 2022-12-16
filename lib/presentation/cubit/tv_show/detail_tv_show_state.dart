part of 'detail_tv_show_cubit.dart';

abstract class DetailTvShowState extends Equatable {
  const DetailTvShowState();

  @override
  List<Object> get props => [];
}

class DetailTvShowInitial extends DetailTvShowState {}

class DetailTvShowLoading extends DetailTvShowState {}

class DetailTvShowFailure extends DetailTvShowState {
  const DetailTvShowFailure(this.message);

  final String? message;
}

class DetailTvShowSuccess extends DetailTvShowState {
  const DetailTvShowSuccess(this.data);

  final DetailTvShowEntity data;
}
