import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class LoadingMovieItem extends StatelessWidget {
  const LoadingMovieItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade600,
          highlightColor: Colors.grey.shade900,
          period: const Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: Row(
              children: [
                const Skeleton(
                  height: 120,
                  width: 80,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Skeleton(
                        height: 20,
                      ),
                      SizedBox(height: 4),
                      Skeleton(
                        height: 16,
                        width: 120,
                      ),
                      SizedBox(height: 4),
                      Skeleton(
                        height: 16,
                        width: 120,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ).toList(),
    );
  }
}
