import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_airing_today_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_on_air_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_popular_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_top_rated_cubit.dart';
import 'package:movie_app/presentation/widgets/background_blur_carousel.dart';
import 'package:movie_app/presentation/widgets/list_horizontal_tv_show.dart';
import 'package:movie_app/presentation/widgets/loading_list_horizontal.dart';
import 'package:movie_app/presentation/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({super.key});

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  //* Cubit
  final _tvShowOnAirCubit = sl<TvShowOnAirCubit>();
  final _tvShowPopularCubit = sl<TvShowPopularCubit>();
  final _tvShowTopRatedCubit = sl<TvShowTopRatedCubit>();
  final _tvShowAiringTodayCubit = sl<TvShowAiringTodayCubit>();

  @override
  void initState() {
    super.initState();
    getTvShowNowPlaying();
    getTvShowPopular();
    getTvShowTopRated();
    getTvShowUpcoming();
  }

  void getTvShowNowPlaying() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _tvShowOnAirCubit.getTvShowOnAir(params);
  }

  void getTvShowPopular() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _tvShowPopularCubit.getTvShowPopular(params);
  }

  void getTvShowTopRated() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _tvShowTopRatedCubit.getTvShowTopRated(params);
  }

  void getTvShowUpcoming() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _tvShowAiringTodayCubit.getTvShowAiringToday(params);
  }

  Future<void> onRefresh() async {
    getTvShowNowPlaying();
    getTvShowPopular();
    getTvShowTopRated();
    getTvShowUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _tvShowOnAirCubit,
        ),
        BlocProvider(
          create: (context) => _tvShowPopularCubit,
        ),
        BlocProvider(
          create: (context) => _tvShowTopRatedCubit,
        ),
        BlocProvider(
          create: (context) => _tvShowAiringTodayCubit,
        ),
      ],
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _onAirTvShow(),
                  _airingTodayTvShow(),
                  _popularTvShow(),
                  _topRatedTvShow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _onAirTvShow() {
    return BlocBuilder<TvShowOnAirCubit, TvShowOnAirState>(
      builder: (context, state) {
        if (state is TvShowOnAirFailure) {
          return const Text('data');
        } else if (state is TvShowOnAirSuccess) {
          final data = state.data;

          return BackgroundBlurCarousel(
            data: data,
            typeShow: TypeShow.tv,
          );
        }
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade800,
          highlightColor: Colors.grey.shade900,
          period: const Duration(milliseconds: 1000),
          child: Skeleton(height: Get.height / 2),
        );
      },
    );
  }

  Widget _airingTodayTvShow() {
    return BlocBuilder<TvShowAiringTodayCubit, TvShowAiringTodayState>(
      builder: (context, state) {
        if (state is TvShowAiringTodaySuccess) {
          return ListHorizontalTvShow(
            title: 'Airing Today',
            data: state.data,
            onSeeAll: () => Get.toNamed<void>(
              NamedRoutes.airingTodayTvShowPage,
            ),
          );
        }

        return const LoadingListHorizontal();
      },
    );
  }

  Widget _popularTvShow() {
    return BlocBuilder<TvShowPopularCubit, TvShowPopularState>(
      builder: (context, state) {
        if (state is TvShowPopularSuccess) {
          return ListHorizontalTvShow(
            title: 'Popular',
            data: state.data,
            onSeeAll: () => Get.toNamed<void>(NamedRoutes.popularTvShowPage),
          );
        }

        return const LoadingListHorizontal();
      },
    );
  }

  Widget _topRatedTvShow() {
    return BlocBuilder<TvShowTopRatedCubit, TvShowTopRatedState>(
      builder: (context, state) {
        if (state is TvShowTopRatedSuccess) {
          return ListHorizontalTvShow(
            title: 'Top Rated',
            data: state.data,
            onSeeAll: () => Get.toNamed<void>(NamedRoutes.topRatedTvShowPage),
          );
        }

        return const LoadingListHorizontal();
      },
    );
  }
}
