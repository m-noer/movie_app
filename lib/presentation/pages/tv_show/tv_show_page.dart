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
import 'package:movie_app/presentation/cubit/tv_show/tv_show_airing_today_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_on_air_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_popular_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_top_rated_cubit.dart';
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

  int _swiperIndex = 0;

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
    final size = MediaQuery.of(context).size;

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
                  SizedBox(
                    height: Get.height / 2,
                    child: BlocBuilder<TvShowOnAirCubit, TvShowOnAirState>(
                      builder: (context, state) {
                        if (state is TvShowOnAirFailure) {
                          return const Text('data');
                        } else if (state is TvShowOnAirSuccess) {
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
                  BlocBuilder<TvShowAiringTodayCubit, TvShowAiringTodayState>(
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
                  ),
                  BlocBuilder<TvShowPopularCubit, TvShowPopularState>(
                    builder: (context, state) {
                      if (state is TvShowPopularSuccess) {
                        return ListHorizontalTvShow(
                          title: 'Popular',
                          data: state.data,
                          onSeeAll: () =>
                              Get.toNamed<void>(NamedRoutes.popularTvShowPage),
                        );
                      }

                      return const LoadingListHorizontal();
                    },
                  ),
                  BlocBuilder<TvShowTopRatedCubit, TvShowTopRatedState>(
                    builder: (context, state) {
                      if (state is TvShowTopRatedSuccess) {
                        return ListHorizontalTvShow(
                          title: 'Top Rated',
                          data: state.data,
                          onSeeAll: () =>
                              Get.toNamed<void>(NamedRoutes.topRatedTvShowPage),
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
