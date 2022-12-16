import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_app/core/constants/value_constant.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/contents/list_movie_content.dart';
import 'package:movie_app/presentation/cubit/movies/movies_upcoming_cubit.dart';
import 'package:movie_app/presentation/widgets/background_blur_carousel.dart';

class UpcomingMoviePage extends StatefulWidget {
  const UpcomingMoviePage({super.key});

  @override
  State<UpcomingMoviePage> createState() => _UpcomingMoviePageState();
}

class _UpcomingMoviePageState extends State<UpcomingMoviePage> {
  //* Cubit
  final _moviesUpcomingCubit = sl<MoviesUpcomingCubit>();

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
    _moviesUpcomingCubit.getMoviesUpcoming(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _moviesUpcomingCubit,
      child: BlocListener<MoviesUpcomingCubit, MoviesUpcomingState>(
        listener: (context, state) {
          if (state is MoviesUpcomingSuccess) {
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
            title: const Text('Upcoming'),
          ),
          body: ListMovieContent(
            backgroundImage: _backgroundImage,
            pagingController: _pagingController,
            typeShow: TypeShow.movie,
          ),
        ),
      ),
    );
  }
}