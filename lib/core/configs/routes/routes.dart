import 'package:get/route_manager.dart';
import 'package:movie_app/core/configs/routes/named_routes.dart';
import 'package:movie_app/presentation/pages/movies/detail_movie_page.dart';
import 'package:movie_app/presentation/pages/movies/popular_movies_page.dart';
import 'package:movie_app/presentation/pages/movies/top_rated_movies.dart';
import 'package:movie_app/presentation/pages/movies/upcoming_movies_page.dart';
import 'package:movie_app/presentation/pages/navigation_page.dart';
import 'package:movie_app/presentation/pages/tv_show/airing_today_tv_page.dart';
import 'package:movie_app/presentation/pages/tv_show/detail_tv_show_page.dart';
import 'package:movie_app/presentation/pages/tv_show/popular_tv_page.dart';
import 'package:movie_app/presentation/pages/tv_show/top_rated_tv_page.dart';

class Routes {
  static List<GetPage<void>> page = <GetPage<void>>[
    GetPage<void>(
      name: NamedRoutes.navigationPage,
      page: () => const NavigationPage(),
    ),
    GetPage<void>(
      name: NamedRoutes.detailMovieId,
      page: () => DetailMoviePage(id: Get.arguments as int),
    ),
    GetPage<void>(
      name: NamedRoutes.popularMoviePage,
      page: () => const PopularMoviePage(),
    ),
    GetPage<void>(
      name: NamedRoutes.topRatedMoviePage,
      page: () => const TopRatedMoviePage(),
    ),
    GetPage<void>(
      name: NamedRoutes.upcomingMoviePage,
      page: () => const UpcomingMoviePage(),
    ),
    GetPage<void>(
      name: NamedRoutes.detailTvShowId,
      page: () => DetailTvShowPage(id: Get.arguments as int),
    ),
    GetPage<void>(
      name: NamedRoutes.popularTvShowPage,
      page: () => const PopularTvPage(),
    ),
    GetPage<void>(
      name: NamedRoutes.topRatedTvShowPage,
      page: () => const TopRatedTvPage(),
    ),
    GetPage<void>(
      name: NamedRoutes.airingTodayTvShowPage,
      page: () => const AiringTodayTvPage(),
    ),
  ];
}
