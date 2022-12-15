import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/vote_average.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.data,
    this.onTap,
  });

  final MovieEntity data;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: '${ApiPath.baseImageUrlW200}${data.posterPath}',
                width: 80,
                placeholder: (context, url) =>
                    const ColoredBox(color: Colors.grey),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? data.name ?? '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.releaseDate ?? data.firstAirDate ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  if (data.voteAverage != 0.0)
                    VoteIndicator(voteAverage: data.voteAverage)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
