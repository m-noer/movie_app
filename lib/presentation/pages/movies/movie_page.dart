import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/presentation/cubit/movies/movies_now_playing_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_popular_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_top_rated_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_upcoming_cubit.dart';
import 'package:movie_app/presentation/widgets/list_horizontal_movie.dart';
import 'package:movie_app/presentation/widgets/loading_list_horizontal.dart';
import 'package:movie_app/presentation/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  //* Cubit
  final _moviesNowPlayingCubit = sl<MoviesNowPlayingCubit>();
  final _moviesPopularCubit = sl<MoviesPopularCubit>();
  final _moviesTopRatedCubit = sl<MoviesTopRatedCubit>();
  final _moviesUpcomingCubit = sl<MoviesUpcomingCubit>();

  int _swiperIndex = 0;

  @override
  void initState() {
    super.initState();
    getMoviesNowPlaying();
    getMoviesPopular();
    getMoviesTopRated();
    getMoviesUpcoming();
  }

  void getMoviesNowPlaying() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesNowPlayingCubit.getMoviesNowPlaying(params);
  }

  void getMoviesPopular() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesPopularCubit.getMoviesPopular(params);
  }

  void getMoviesTopRated() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesTopRatedCubit.getMoviesTopRated(params);
  }

  void getMoviesUpcoming() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesUpcomingCubit.getMoviesUpcoming(params);
  }

  Future<void> onRefresh() async {
    getMoviesNowPlaying();
    getMoviesPopular();
    getMoviesTopRated();
    getMoviesUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _moviesNowPlayingCubit,
        ),
        BlocProvider(
          create: (context) => _moviesPopularCubit,
        ),
        BlocProvider(
          create: (context) => _moviesTopRatedCubit,
        ),
        BlocProvider(
          create: (context) => _moviesUpcomingCubit,
        ),
      ],
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 2,
                    child: BlocBuilder<MoviesNowPlayingCubit,
                        MoviesNowPlayingState>(
                      builder: (context, state) {
                        if (state is MoviesNowPlayingFailure) {
                          return const Text('data');
                        } else if (state is MoviesNowPlayingSuccess) {
                          final data = state.data;

                          return Stack(
                            children: [
                              Container(
                                height: Get.height / 2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      size.width > 600
                                          ? '''${ApiPath.baseImageUrl}${data[_swiperIndex].backdropPath!}'''
                                          : '''${ApiPath.baseImageUrl}${data[_swiperIndex].posterPath!}''',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  // ignore: use_decorated_box
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0),
                                    ),
                                  ),
                                ),
                              ),
                              Swiper(
                                onIndexChanged: (value) {
                                  setState(() {
                                    _swiperIndex = value;
                                  });
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: InkWell(
                                        onTap: () => Get.toNamed<void>(
                                          '${NamedRoutes.detailMovie}/${data[index].id}',
                                          arguments: data[index].id,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: size.width > 600
                                              ? '''${ApiPath.baseImageUrl}${data[index].backdropPath!}'''
                                              : '''${ApiPath.baseImageUrl}${data[index].posterPath!}''',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 5,
                                viewportFraction: 0.7,
                                scale: 0.9,
                              ),
                            ],
                          );
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade900,
                          period: const Duration(milliseconds: 1000),
                          child: Skeleton(height: Get.height / 2),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<MoviesPopularCubit, MoviesPopularState>(
                    builder: (context, state) {
                      if (state is MoviesPopularSuccess) {
                        return ListHorizontalMovie(
                          title: 'Popular',
                          data: state.data,
                          onSeeAll: () =>
                              Get.toNamed<void>(NamedRoutes.popularMoviePage),
                        );
                      }

                      return const LoadingListHorizontal();
                    },
                  ),
                  BlocBuilder<MoviesTopRatedCubit, MoviesTopRatedState>(
                    builder: (context, state) {
                      if (state is MoviesTopRatedSuccess) {
                        return ListHorizontalMovie(
                          title: 'Top Rated',
                          data: state.data,
                          onSeeAll: () =>
                              Get.toNamed<void>(NamedRoutes.topRatedMoviePage),
                        );
                      }

                      return const LoadingListHorizontal();
                    },
                  ),
                  BlocBuilder<MoviesUpcomingCubit, MoviesUpcomingState>(
                    builder: (context, state) {
                      if (state is MoviesUpcomingSuccess) {
                        return ListHorizontalMovie(
                          title: 'Upcoming',
                          data: state.data,
                          onSeeAll: () =>
                              Get.toNamed<void>(NamedRoutes.upcomingMoviePage),
                        );
                      }

                      return const LoadingListHorizontal();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
