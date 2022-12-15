import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/blur_background_image.dart';
import 'package:movie_app/presentation/widgets/loading_movie_item.dart';
import 'package:movie_app/presentation/widgets/movie_item.dart';

class ListMovieContent extends StatelessWidget {
  const ListMovieContent({
    super.key,
    required ValueNotifier<String?> backgroundImage,
    required PagingController<int, MovieEntity> pagingController,
  })  : _backgroundImage = backgroundImage,
        _pagingController = pagingController;

  final ValueNotifier<String?> _backgroundImage;
  final PagingController<int, MovieEntity> _pagingController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _backgroundImage,
          builder: (context, value, child) => BlurIBackgroundmage(
            imagePath: value,
          ),
        ),
        RefreshIndicator(
          onRefresh: () async => _pagingController.refresh(),
          child: PagedListView<int, MovieEntity>(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
              itemBuilder: (context, data, index) => MovieItem(
                onTap: () => Get.toNamed<void>(
                  '${NamedRoutes.detailMovie}/${data.id}',
                  arguments: data.id,
                ),
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
