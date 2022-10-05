import '../core/lib/data/datasources/db/database_helper.dart';
import '../core/lib/data/datasources/tv_series_remote_data_source.dart';
import '../core/lib/data/datasources/watchlist_local_data_source.dart';
import '../core/lib/data/datasources/movie_remote_data_source.dart';
import '../core/lib/data/repositories/movie_repository_impl.dart';
import '../core/lib/data/repositories/tv_series_repository_impl.dart';
import '../core/lib/data/repositories/watchlist_repository_impl.dart';
import '../core/lib/domain/repositories/movie_repository.dart';
import '../core/lib/domain/repositories/tv_series_repository.dart';
import '../core/lib/domain/repositories/watchlist_repository.dart';
import '../core/lib/domain/usecases/movie/get_movie_detail.dart';
import '../core/lib/domain/usecases/movie/get_movie_recommendations.dart';
import '../core/lib/domain/usecases/movie/get_now_playing_movies.dart';
import '../core/lib/domain/usecases/movie/get_popular_movies.dart';
import '../core/lib/domain/usecases/movie/get_top_rated_movies.dart';
import '../core/lib/domain/usecases/tv/get_detail_tv_series.dart';
import '../core/lib/domain/usecases/tv/get_on_the_air_tv_series.dart';
import '../core/lib/domain/usecases/tv/get_popular_tv_series.dart';
import '../core/lib/domain/usecases/tv/get_recommendation_tv_series.dart';
import '../core/lib/domain/usecases/tv/get_season_detail_tv_series.dart';
import '../core/lib/domain/usecases/tv/get_top_rated_tv_series.dart';
import '../core/lib/domain/usecases/tv/search_tv_series.dart';
import '../core/lib/domain/usecases/watchlist/get_watchlist.dart';
import '../core/lib/domain/usecases/watchlist/get_watchlist_status.dart';
import '../core/lib/domain/usecases/watchlist/remove_watchlist.dart';
import '../core/lib/domain/usecases/watchlist/save_watchlist.dart';
import '../core/lib/domain/usecases/movie/search_movies.dart';
import '../core/lib/presentation/provider/movie/movie_detail_notifier.dart';
import '../core/lib/presentation/provider/movie/movie_list_notifier.dart';
import '../core/lib/presentation/provider/movie/movie_search_notifier.dart';
import '../core/lib/presentation/provider/movie/popular_movies_notifier.dart';
import '../core/lib/presentation/provider/movie/top_rated_movies_notifier.dart';
import '../core/lib/presentation/provider/tv/detail_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/list_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/on_the_air_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/popular_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/recommendation_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/search_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/season_detail_tv_series_notifier.dart';
import '../core/lib/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import '../core/lib/presentation/provider/watchlist_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
void init() {
  // provider
  // movie provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  // watchlist provider
  locator.registerFactory(
    () => WatchlistNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // TV Series provider
  locator.registerFactory(
    () => ListTVSeriesNotifier(
      getOnTheAirTVSeries: locator(),
      getPopularTVSeries: locator(),
      getTopRatedTVSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => OnTheAirTVSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => PopularTVSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => TopRatedTVSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => DetailTVSeriesNotifier(
      getDetailTVSeries: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTVSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => SearchTVSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => SeasonDetailTVSeriesNotifier(locator()),
  );

  // Movies usecases / Bussiness Logic
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  // TVSeries usecases / Bussiness Logic
  locator.registerLazySingleton(
    () => GetOnTheAirTVSeries(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetPopularTVSeries(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetTopRatedTVSeries(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetDetailTVSeries(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetRecommendationTVSeries(repository: locator()),
  );
  locator.registerLazySingleton(
    () => GetSeasonDetailTVSeries(repository: locator()),
  );
  locator.registerLazySingleton(
    () => SearchTVSeries(repository: locator()),
  );

  // Watchlist usecases / Bussiness Logic
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));

  //  repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: locator()),
  );
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(localDataSource: locator()),
  );
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(remoteDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<WatchlistLocalDataSource>(
    () => WatchlistLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
    () => TVSeriesRemoteDataSourceImpl(client: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
