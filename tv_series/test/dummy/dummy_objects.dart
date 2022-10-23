import 'package:watchlist/models/watchlist_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/domain/entities/tv/season.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:watchlist/entity/watchlist.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);
final testTVSeriesDetail = TVSeriesDetail(
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
