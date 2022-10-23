import 'package:mockito/annotations.dart';
import 'package:watchlist/watchlist_data.dart';
import 'package:watchlist/watchlist_domain.dart';

@GenerateMocks([
  WatchlistRepository,
  WatchlistLocalDataSource,
  DatabaseHelper,
])
void main() {}
