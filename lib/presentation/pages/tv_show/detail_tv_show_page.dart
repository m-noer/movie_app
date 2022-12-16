import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/presentation/contents/detail_tv_show_content.dart';
import 'package:movie_app/presentation/cubit/tv_show/detail_tv_show_cubit.dart';

class DetailTvShowPage extends StatefulWidget {
  const DetailTvShowPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<DetailTvShowPage> createState() => _DetailTvShowPageState();
}

class _DetailTvShowPageState extends State<DetailTvShowPage> {
  final _detailTvShowCubit = sl<DetailTvShowCubit>();

  @override
  void initState() {
    super.initState();
    getDetailTvShow();
  }

  void getDetailTvShow() {
    _detailTvShowCubit.getDetailTvShow(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailTvShowCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DetailTvShowCubit, DetailTvShowState>(
            builder: (context, state) {
              if (state is DetailTvShowSuccess) {
                final data = state.data;

                return DetailTvShowContent(data: data);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
