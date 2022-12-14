import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/data/models/models.dart';
import 'package:movie_app/presentation/cubit/movies_now_playing_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* Cubit
  final _moviesNowPlayingCubit = sl<MoviesNowPlayingCubit>();

  int _swiperIndex = 0;

  @override
  void initState() {
    super.initState();
    getMoviesNowPlaying();
  }

  void getMoviesNowPlaying() {
    final params = MovieQueryParameter(
      page: 1,
      language: 'id',
      region: 'id',
    );
    _moviesNowPlayingCubit.getMoviesNowPlaying(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _moviesNowPlayingCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 420,
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
                            height: 420,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  'https://image.tmdb.org/t/p/original${data[_swiperIndex].posterPath!}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
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
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: InkWell(
                                        onTap: () {
                                          print('object');
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original${data[index].posterPath!}',
                                          fit: BoxFit.cover,
                                          width: Get.width,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: 3,
                            viewportFraction: 0.7,
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
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<MoviesNowPlayingCubit, MoviesNowPlayingState>(
                      builder: (context, state) {
                        if (state is MoviesNowPlayingSuccess) {
                          final data = state.data;

                          return SizedBox(
                            height: 280,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: SizedBox(
                                  width: 160,
                                  height: 180,
                                  child: Stack(
                                    children: [
                                      Card(
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
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                data[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: Colors.black,
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const CircularProgressIndicator(
                                                value: 80 / 100,
                                                color: Colors.greenAccent,
                                                strokeWidth: 2,
                                              ),
                                              Text(
                                                '100',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              )
                                            ],
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
    );
  }
}
