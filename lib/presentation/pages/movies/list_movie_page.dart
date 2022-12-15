import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/core/constants/value_constant.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/cubit/movies/movies_top_rated_cubit.dart';
import 'package:movie_app/presentation/pages/movies/detail_movie_page.dart';
import 'package:movie_app/presentation/widgets/movie_item.dart';

class ListMoviePage extends StatefulWidget {
  const ListMoviePage({
    super.key,
    required this.listener,
  });

  final void Function(int) listener;

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  //* Cubit
  final _moviesTopRatedCubit = sl<MoviesTopRatedCubit>();

  //* Controller
  final _pagingController = PagingController<int, MovieEntity>(firstPageKey: 1);
  final _backgroundImage = ValueNotifier<String?>(null);

  int pageNumber = ValueConstant.firstPage;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(widget.listener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _moviesTopRatedCubit,
      child: BlocListener<MoviesTopRatedCubit, MoviesTopRatedState>(
        listener: (context, state) {
          if (state is MoviesTopRatedSuccess) {
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
            title: const Text('Top Rated'),
          ),
          body: Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: _backgroundImage,
                builder: (context, value, child) => Container(
                  height: Get.height / 1.8,
                  decoration: BoxDecoration(
                    image: value != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                              '''${ApiPath.baseImageUrlW200}$value''',
                            ),
                            onError: (exception, stackTrace) {},
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 40,
                      sigmaY: 40,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              PagedListView<int, MovieEntity>(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
                  itemBuilder: (context, data, index) => MovieItem(
                    onTap: () => Get.to<void>(
                      () => DetailMoviePage(
                        id: data.id,
                      ),
                    ),
                    data: data,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
