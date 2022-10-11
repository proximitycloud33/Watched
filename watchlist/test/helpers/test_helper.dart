import '../../../watchlist/lib/data/datasource/db/database_helper.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import '../../../tv_series/lib/data/datasources/tv_series_remote_data_source.dart';
import '../../../watchlist/lib/data/datasource/watchlist_local_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import '../../../watchlist/lib/domain/watchlist_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  WatchlistRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
