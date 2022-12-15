import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/presentation/contents/detail_movie_content.dart';
import 'package:movie_app/presentation/cubit/movies/detail_movie_cubit.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  final _detailMovieCubit = sl<DetailMovieCubit>();

  @override
  void initState() {
    super.initState();
    getDetailMovie();
  }

  void getDetailMovie() {
    _detailMovieCubit.getDetailMovie(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailMovieCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DetailMovieCubit, DetailMovieState>(
            builder: (context, state) {
              if (state is DetailMovieSuccess) {
                final data = state.data;

                return DetailMovieContent(data: data);
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
