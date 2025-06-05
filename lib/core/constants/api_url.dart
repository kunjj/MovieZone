class ApiUrl {
  static const baseUrl = 'https://movie-backend-production-8413.up.railway.app/';
  static const _apiV = 'api/v1/';

  static const signUp = '${_apiV}auth/signup';
  static const signIn = '${_apiV}auth/signin';
  static const trendingMovies = '${_apiV}movie/trending';
  static const nowPlayingMovies = '${_apiV}movie/nowplaying';
  static const popularTV = '${_apiV}tv/popular';
  static const movie = '${_apiV}movie/';
  static const tv = '${_apiV}tv/';
  static const search = '${_apiV}search/';

  static const trailerBase = 'https://www.youtube.com/watch?v=';
}
