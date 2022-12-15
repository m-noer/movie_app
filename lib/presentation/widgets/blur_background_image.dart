import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movie_app/core/constants/api_path.dart';

class BlurIBackgroundmage extends StatelessWidget {
  const BlurIBackgroundmage({
    super.key,
    this.imagePath,
    this.height,
  });

  final String? imagePath;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Get.height / 2,
      decoration: BoxDecoration(
        image: imagePath != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(
                  '''${ApiPath.baseImageUrlW200}$imagePath''',
                ),
                onError: (exception, stackTrace) {},
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 40,
          sigmaY: 40,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
