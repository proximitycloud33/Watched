import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

const testTVSeriesDetail = TVSeriesDetail(
  adult: false,
  firstAirDate: '2022-08-21',
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'Dragon',
  originalName: 'House of Dragon',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  seasons: [
    Season(
      airDate: '2022-08-21',
      episodeCount: 10,
      id: 1,
      name: 'Dragon',
      overview: '',
      posterPath: '',
      seasonNumber: 1,
    )
  ],
  voteAverage: 1,
  voteCount: 1,
);

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
