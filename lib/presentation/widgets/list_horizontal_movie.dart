import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';

import 'package:movie_app/domain/entities/entities.dart';
import 'package:movie_app/presentation/widgets/movie_card.dart';

class ListHorizontalMovie extends StatelessWidget {
  const ListHorizontalMovie({
    super.key,
    required this.title,
    required this.data,
    this.onSeeAll,
  });

  final String title;
  final List<MovieEntity> data;
  final void Function()? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length > 5 ? 5 : data.length,
              itemBuilder: (context, index) => MovieCard(
                onTap: () => Get.toNamed<void>(
                  '${NamedRoutes.detailMovie}/${data[index].id}',
                  arguments: data[index].id,
                ),
                data: data[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
