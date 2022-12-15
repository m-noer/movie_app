import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/vote_average.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.data,
    this.onTap,
  });

  final MovieEntity data;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: SizedBox(
        width: 160,
        height: 180,
        child: Stack(
          children: [
            Card(
              child: InkWell(
                onTap: onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl:
                            '''${ApiPath.baseImageUrl}${data.posterPath!}''',
                        fit: BoxFit.cover,
                        height: 220,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        data.title ?? data.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (data.voteAverage != 0.0)
              Positioned(
                top: 8,
                right: 8,
                child: VoteIndicator(
                  voteAverage: data.voteAverage,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
