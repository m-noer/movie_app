class ApiPath {
  static const String login = '/auth/login';
  static const String movie = '/movie';
  static const String moviesNowPlaying = '$movie/now_playing';
  static const String moviesTopRated = '$movie/top_rated';
  static const String moviesUpcoming = '$movie/upcoming';
  static const String moviesPopular = '$movie/popular';

  static const String tv = '/tv';
  static const String tvOnAir = '$tv/on_the_air';
  static const String tvTopRated = '$tv/top_rated';
  static const String tvAiringToday = '$tv/airing_today';
  static const String tvPopular = '$tv/popular';

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseImageUrlW200 = 'https://image.tmdb.org/t/p/w200';
}
