import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/dio_handler.dart';
import 'package:movie_app/data/data_sources/movies_remote_data_source.dart';
import 'package:movie_app/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/domain/use_cases/get_detail_movie_use_case.dart';
import 'package:movie_app/domain/use_cases/get_movies_now_playing_use_case.dart';
import 'package:movie_app/domain/use_cases/get_movies_top_rated_use_case.dart';
import 'package:movie_app/presentation/cubit/detail_movie_cubit.dart';
import 'package:movie_app/presentation/cubit/movies_now_playing_cubit.dart';
import 'package:movie_app/presentation/cubit/movies_top_rated_cubit.dart';

final sl = GetIt.instance;

class Injections {
  Future<void> init() async {
    // Cubit
    sl.registerFactory(() => MoviesNowPlayingCubit(sl()));
    sl.registerFactory(() => MoviesTopRatedCubit(sl()));
    sl.registerFactory(() => DetailMovieCubit(sl()));

    // Use cases
    sl.registerFactory(() => GetMoviesNowPlayingUseCase(sl()));
    sl.registerFactory(() => GetMoviesTopRatedUseCase(sl()));
    sl.registerFactory(() => GetDetailMovieUseCase(sl()));

    // Repository
    sl.registerFactory<MoviesRepository>(() => MoviesRepositoryImpl(sl()));

    // Data sources
    sl.registerFactory<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(sl()),
    );

    // Network

    sl.registerFactory<Dio>(() => sl<DioHandler>().dio);
    sl.registerFactory(DioHandler.new);
  }
}
