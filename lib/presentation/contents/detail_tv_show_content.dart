import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/core/constants/api_path.dart';

import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/vote_average.dart';

class DetailTvShowContent extends StatelessWidget {
  const DetailTvShowContent({
    super.key,
    required this.data,
  });

  final DetailTvShowEntity data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                if (data.backdropPath != null)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          '''${ApiPath.baseImageUrl}${data.posterPath}''',
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
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () => Get.back<void>(),
                    icon: const Icon(
                      FluentIcons.dismiss_20_filled,
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
                          SizedBox(
                            height: 120,
                            width: 80,
                            child: CachedNetworkImage(
                              imageUrl:
                                  '''${ApiPath.baseImageUrlW200}${data.posterPath!}''',
                              placeholder: (context, url) => const ColoredBox(
                                color: Colors.grey,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DateFormat('dd MMMM yyyy').format(
                                            DateTime.parse(data.firstAirDate),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${data.numberOfEpisodes} Episode',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                    if (data.voteAverage != 0.0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: VoteIndicator(
                                          voteAverage:
                                              data.voteAverage.toPrecision(1),
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overview',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.overview ?? '-',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Genres',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  children: data.genres
                      .map(
                        (genre) => Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Chip(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            label: Text(
                              genre.name,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
