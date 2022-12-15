import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/dio_handler.dart';
import 'package:movie_app/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/data/data_sources/tv_show_remote_data_source.dart';
import 'package:movie_app/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/data/repositories/tv_show_repository_impl.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/domain/repositories/tv_show_repository.dart';
import 'package:movie_app/domain/use_cases/movies/get_detail_movie_use_case.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_now_playing_use_case.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_popular_use_case.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_top_rated_use_case.dart';
import 'package:movie_app/domain/use_cases/movies/get_movies_upcoming_use_case.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_detail_tv_show_use_case.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_airing_today_use_case.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_on_air_use_case.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_popular_use_case.dart';
import 'package:movie_app/domain/use_cases/tv_show/get_tv_show_top_rated_use_case.dart';
import 'package:movie_app/presentation/cubit/movies/detail_movie_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_now_playing_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_popular_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_top_rated_cubit.dart';
import 'package:movie_app/presentation/cubit/movies/movies_upcoming_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/detail_tv_show_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_airing_today_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_on_air_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_popular_cubit.dart';
import 'package:movie_app/presentation/cubit/tv_show/tv_show_top_rated_cubit.dart';

final sl = GetIt.instance;

class Injections {
  Future<void> init() async {
    // Cubit
    sl.registerFactory(() => MoviesNowPlayingCubit(sl()));
    sl.registerFactory(() => MoviesTopRatedCubit(sl()));
    sl.registerFactory(() => DetailMovieCubit(sl()));
    sl.registerFactory(() => MoviesUpcomingCubit(sl()));
    sl.registerFactory(() => MoviesPopularCubit(sl()));

    sl.registerFactory(() => TvShowOnAirCubit(sl()));
    sl.registerFactory(() => TvShowTopRatedCubit(sl()));
    sl.registerFactory(() => DetailTvShowCubit(sl()));
    sl.registerFactory(() => TvShowAiringTodayCubit(sl()));
    sl.registerFactory(() => TvShowPopularCubit(sl()));

    // Use cases
    sl.registerFactory(() => GetMoviesNowPlayingUseCase(sl()));
    sl.registerFactory(() => GetMoviesTopRatedUseCase(sl()));
    sl.registerFactory(() => GetDetailMovieUseCase(sl()));
    sl.registerFactory(() => GetMoviesUpcomingUseCase(sl()));
    sl.registerFactory(() => GetMoviesPopularUseCase(sl()));

    sl.registerFactory(() => GetTvShowOnAirUseCase(sl()));
    sl.registerFactory(() => GetTvShowTopRatedUseCase(sl()));
    sl.registerFactory(() => GetDetailTvShowUseCase(sl()));
    sl.registerFactory(() => GetTvShowAiringTodayUseCase(sl()));
    sl.registerFactory(() => GetTvShowPopularUseCase(sl()));

    // Repository
    sl.registerFactory<MoviesRepository>(() => MoviesRepositoryImpl(sl()));
    sl.registerFactory<TvShowRepository>(() => TvShowRepositoryImpl(sl()));

    // Data sources
    sl.registerFactory<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(sl()),
    );
    sl.registerFactory<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(sl()),
    );

    // Network

    sl.registerFactory<Dio>(() => sl<DioHandler>().dio);
    sl.registerFactory(DioHandler.new);
  }
}
