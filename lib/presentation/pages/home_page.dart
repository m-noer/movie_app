import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/presentation/cubit/movies_now_playing_cubit.dart';
import 'package:movie_app/presentation/cubit/movies_top_rated_cubit.dart';
import 'package:movie_app/presentation/pages/detail_movie_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* Cubit
  final _moviesNowPlayingCubit = sl<MoviesNowPlayingCubit>();
  final _moviesTopRatedCubit = sl<MoviesTopRatedCubit>();

  int _swiperIndex = 0;

  @override
  void initState() {
    super.initState();
    getMoviesNowPlaying();
    getMoviesTopRated();
  }

  void getMoviesNowPlaying() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesNowPlayingCubit.getMoviesNowPlaying(params);
  }

  void getMoviesTopRated() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesTopRatedCubit.getMoviesTopRated(params);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _moviesNowPlayingCubit,
        ),
        BlocProvider(
          create: (context) => _moviesTopRatedCubit,
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 2,
                  child:
                      BlocBuilder<MoviesNowPlayingCubit, MoviesNowPlayingState>(
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
                                        ? 'https://image.tmdb.org/t/p/original//${data[_swiperIndex].backdropPath!}'
                                        : 'https://image.tmdb.org/t/p/original${data[_swiperIndex].posterPath!}',
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
                                      onTap: () {
                                        log('object');
                                        Get.to<void>(
                                          () => DetailMoviePage(
                                            id: data[index].id,
                                          ),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: size.width > 600
                                            ? 'https://image.tmdb.org/t/p/original${data[index].backdropPath!}'
                                            : 'https://image.tmdb.org/t/p/original${data[index].posterPath!}',
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
                      return const SizedBox();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Top Rated',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'See all',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<MoviesTopRatedCubit, MoviesTopRatedState>(
                        builder: (context, state) {
                          if (state is MoviesTopRatedSuccess) {
                            final data = state.data;

                            return SizedBox(
                              height: 280,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: SizedBox(
                                    width: 160,
                                    height: 180,
                                    child: Stack(
                                      children: [
                                        Card(
                                          child: InkWell(
                                            onTap: () => Get.to<void>(
                                              () => DetailMoviePage(
                                                id: data[index].id,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/original${data[index].posterPath!}',
                                                    fit: BoxFit.cover,
                                                    height: 220,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    data[index].title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(44),
                                              color: Colors.black,
                                            ),
                                            child: Center(
                                              child: CircularPercentIndicator(
                                                radius: 18,
                                                lineWidth: 2,
                                                percent:
                                                    data[index].voteAverage /
                                                        10,
                                                center: Text(
                                                  '${data[index].voteAverage}',
                                                ),
                                                progressColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
