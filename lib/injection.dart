import 'package:core/notifier.dart';
import 'package:core/usecases.dart';
import 'package:core/data_repository.dart';
import 'package:core/domain_repository.dart';
import 'package:core/datasources.dart';
import 'package:search/search.dart';
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
