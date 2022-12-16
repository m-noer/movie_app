import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/core/constants/api_path.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/blur_background_image.dart';

enum TypeShow { movie, tv }

class BackgroundBlurCarousel extends StatefulWidget {
  const BackgroundBlurCarousel({
    super.key,
    required this.data,
    required this.typeShow,
  });

  final List<MovieEntity> data;
  final TypeShow typeShow;

  @override
  State<BackgroundBlurCarousel> createState() => _BackgroundBlurCarouselState();
}

class _BackgroundBlurCarouselState extends State<BackgroundBlurCarousel> {
  int _swiperIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: Get.height / 2,
      child: Stack(
        children: [
          BlurIBackgroundmage(
            imagePath: size.width > 600
                ? '''${ApiPath.baseImageUrl}${widget.data[_swiperIndex].backdropPath!}'''
                : '''${ApiPath.baseImageUrl}${widget.data[_swiperIndex].posterPath!}''',
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
                      if (widget.typeShow == TypeShow.movie) {
                        Get.toNamed<void>(
                          '${NamedRoutes.detailMovie}/${widget.data[index].id}',
                          arguments: widget.data[index].id,
                        );
                      } else {
                        Get.toNamed<void>(
                          '${NamedRoutes.detailTvShow}/${widget.data[index].id}',
                          arguments: widget.data[index].id,
                        );
                      }
                    },
                    child: CachedNetworkImage(
                      imageUrl: size.width > 600
                          ? '''${ApiPath.baseImageUrl}${widget.data[index].backdropPath!}'''
                          : '''${ApiPath.baseImageUrl}${widget.data[index].posterPath!}''',
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
      ),
    );
  }
}
