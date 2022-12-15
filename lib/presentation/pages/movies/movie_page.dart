import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/presentation/cubit/movies/movies_now_playing_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_popular_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_top_rated_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_upcoming_cubit.dart';
import 'package:movie_app/presentation/widgets/background_blur_carousel.dart';
import 'package:movie_app/presentation/widgets/list_horizontal_movie.dart';
import 'package:movie_app/presentation/widgets/loading_hero_image.dart';
import 'package:movie_app/presentation/widgets/loading_list_horizontal.dart';

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
                  _nowPlaying(),
                  _popularMovies(),
                  _topRatedMovies(),
                  _upcomingMovies(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nowPlaying() {
    return BlocBuilder<MoviesNowPlayingCubit, MoviesNowPlayingState>(
      builder: (context, state) {
        if (state is MoviesNowPlayingSuccess) {
          final data = state.data;

          return BackgroundBlurCarousel(
            data: data,
            typeShow: TypeShow.movie,
          );
        }
        return const LoadingHeroImage();
      },
    );
  }

  Widget _popularMovies() {
    return BlocBuilder<MoviesPopularCubit, MoviesPopularState>(
      builder: (context, state) {
        if (state is MoviesPopularSuccess) {
          return ListHorizontalMovie(
            title: 'Popular',
            data: state.data,
            onSeeAll: () => Get.toNamed<void>(NamedRoutes.popularMoviePage),
          );
        } else if (state is MoviesPopularLoading) {
          return const LoadingListHorizontal();
        }

        return const SizedBox();
      },
    );
  }

  Widget _topRatedMovies() {
    return BlocBuilder<MoviesTopRatedCubit, MoviesTopRatedState>(
      builder: (context, state) {
        if (state is MoviesTopRatedSuccess) {
          return ListHorizontalMovie(
            title: 'Top Rated',
            data: state.data,
            onSeeAll: () => Get.toNamed<void>(NamedRoutes.topRatedMoviePage),
          );
        } else if (state is MoviesTopRatedLoading) {
          return const LoadingListHorizontal();
        }

        return const SizedBox();
      },
    );
  }

  Widget _upcomingMovies() {
    return BlocBuilder<MoviesUpcomingCubit, MoviesUpcomingState>(
      builder: (context, state) {
        if (state is MoviesUpcomingSuccess) {
          return ListHorizontalMovie(
            title: 'Upcoming',
            data: state.data,
            onSeeAll: () => Get.toNamed<void>(NamedRoutes.upcomingMoviePage),
          );
        } else if (state is MoviesUpcomingLoading) {
          return const LoadingListHorizontal();
        }

        return const SizedBox();
      },
    );
  }
}
