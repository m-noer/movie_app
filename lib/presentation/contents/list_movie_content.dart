import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/background_blur_carousel.dart';
import 'package:movie_app/presentation/widgets/blur_background_image.dart';
import 'package:movie_app/presentation/widgets/loading_movie_item.dart';
import 'package:movie_app/presentation/widgets/movie_item.dart';

class ListMovieContent extends StatelessWidget {
  const ListMovieContent({
    super.key,
    required this.backgroundImage,
    required this.pagingController,
    required this.typeShow,
  });

  final ValueNotifier<String?> backgroundImage;
  final PagingController<int, MovieEntity> pagingController;
  final TypeShow typeShow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: backgroundImage,
          builder: (context, value, child) => BlurIBackgroundmage(
            imagePath: value,
          ),
        ),
        RefreshIndicator(
          onRefresh: () async => pagingController.refresh(),
          child: PagedListView<int, MovieEntity>(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
              itemBuilder: (context, data, index) => MovieItem(
                onTap: () {
                  if (typeShow == TypeShow.movie) {
                    Get.toNamed<void>(
                      '${NamedRoutes.detailMovie}/${data.id}',
                      arguments: data.id,
                    );
                  } else {
                    Get.toNamed<void>(
                      '${NamedRoutes.detailTvShow}/${data.id}',
                      arguments: data.id,
                    );
                  }
                },
                data: data,
              ),
              firstPageProgressIndicatorBuilder: (context) =>
                  const LoadingMovieItem(),
            ),
          ),
        ),
      ],
    );
  }
}
