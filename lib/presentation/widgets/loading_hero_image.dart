import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/presentation/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';

class LoadingHeroImage extends StatelessWidget {
  const LoadingHeroImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade800,
      highlightColor: Colors.grey.shade900,
      period: const Duration(milliseconds: 1000),
      child: Skeleton(height: Get.height / 2),
    );
  }
}
