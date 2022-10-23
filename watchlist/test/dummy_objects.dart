import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

const testWatchlistTable = WatchlistTable(
  id: 1,
  type: 'tv',
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlist = Watchlist(
  id: 1,
  type: 'tv',
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testListofWatchlist = [testWatchlist];

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testWatchlistMap = {
  'id': 1,
  'type': 'tv',
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
