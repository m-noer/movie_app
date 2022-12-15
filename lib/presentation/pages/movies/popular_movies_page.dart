import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_app/core/constants/value_constant.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/contents/list_movie_content.dart';
import 'package:movie_app/presentation/cubit/movies/movies_popular_cubit.dart';

class PopularMoviePage extends StatefulWidget {
  const PopularMoviePage({super.key});

  @override
  State<PopularMoviePage> createState() => _PopularMoviePageState();
}

class _PopularMoviePageState extends State<PopularMoviePage> {
  //* Cubit
  final _moviesPopularCubit = sl<MoviesPopularCubit>();

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
    _moviesPopularCubit.getMoviesPopular(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _moviesPopularCubit,
      child: BlocListener<MoviesPopularCubit, MoviesPopularState>(
        listener: (context, state) {
          if (state is MoviesPopularSuccess) {
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
            title: const Text('Popular'),
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
