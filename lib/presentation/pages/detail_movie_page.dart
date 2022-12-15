import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/di/injection.dart';
import 'package:movie_app/presentation/cubit/detail_movie_cubit.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  final _detailMovieCubit = sl<DetailMovieCubit>();

  @override
  void initState() {
    super.initState();
    getDetailMovie();
  }

  void getDetailMovie() {
    _detailMovieCubit.getDetailMovie(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailMovieCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DetailMovieCubit, DetailMovieState>(
            builder: (context, state) {
              if (state is DetailMovieSuccess) {
                final data = state.data;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height / 2.5,
                        child: Stack(
                          children: [
                            if (data.backdropPath != null)
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      'https://image.tmdb.org/t/p/original${data.backdropPath!}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 20,
                                    sigmaY: 20,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0),
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      if (data.posterPath != null)
                                        CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original${data.posterPath!}',
                                          width: 100,
                                        ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              data.productionCompanies[0].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data.overview ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          height: 1.6,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
