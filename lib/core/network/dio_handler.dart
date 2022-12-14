import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioHandler {
  Dio get dio => _getDio();

  Dio _getDio() {
    final options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      connectTimeout: 20000,
      receiveTimeout: 20000,
      receiveDataWhenStatusError: true,
      queryParameters: {'api_key': '609e7b6ae6f36e4074d83e9efbfdd760'},
    );

    final dio = Dio(options);

    dio.interceptors.addAll(<Interceptor>[
      _loggingInterceptor(),
      RetryInterceptor(
        dio: dio,
        logPrint: log,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 3),
        ],
      ),
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    ]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.forEach((k, dynamic v) => log('$k: $v'));
        options.queryParameters.forEach((k, dynamic v) => log('$k: $v'));

        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (error, handler) {
        return handler.next(error); //continue
      },
    );
  }
}
