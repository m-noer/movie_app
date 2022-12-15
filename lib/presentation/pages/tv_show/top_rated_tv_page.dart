import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_app/core/constants/value_constant.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/contents/list_movie_content.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_top_rated_cubit.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({super.key});

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  //* Cubit
  final _tvTopRatedCubit = sl<TvShowTopRatedCubit>();

  //* Controller
  final _pagingController = PagingController<int, MovieEntity>(firstPageKey: 1);
  final _backgroundImage = ValueNotifier<String?>(null);

  int pageNumber = ValueConstant.firstPage;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(getListMovies);
  }

  void getListMovies(int pageKey) {
    final params = MovieQueryParameter(
      page: pageKey,
      language: 'id',
      region: 'id',
    );
    _tvTopRatedCubit.getTvShowTopRated(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _tvTopRatedCubit,
      child: BlocListener<TvShowTopRatedCubit, TvShowTopRatedState>(
        listener: (context, state) {
          if (state is TvShowTopRatedSuccess) {
            final next = 1 + pageNumber;

            if (pageNumber == ValueConstant.firstPage) {
              _backgroundImage.value = state.data.first.posterPath;
            }

            final isLastPage = state.data.length < ValueConstant.pageSize;

            if (isLastPage) {
              _pagingController.appendLastPage(state.data);
              pageNumber = 0;
            } else {
              _pagingController.appendPage(state.data, next);
            }
            pageNumber++;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Top Rated TV Show'),
          ),
          body: ListMovieContent(
            backgroundImage: _backgroundImage,
            pagingController: _pagingController,
          ),
        ),
      ),
    );
  }
}
