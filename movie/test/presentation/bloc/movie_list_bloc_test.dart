import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie_domain.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';

import 'mocks/movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies, GetNowPlayingMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(
    () {
      mockGetNowPlayingMovies = MockGetNowPlayingMovies();
      mockGetPopularMovies = MockGetPopularMovies();
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      movieListBloc = MovieListBloc(
        mockGetNowPlayingMovies,
        mockGetPopularMovies,
        mockGetTopRatedMovies,
      );
    },
  );
  const tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];
  group('Now Playing movies', () {
    test('Starting state should be empty', () {
      expect(movieListBloc.state.nowPlayingMoviesState, RequestState.empty);
    });
    blocTest<MovieListBloc, MovieListState>(
      'emits a new nowPlayingMovies data when MovieListNowPlayingFetched is executed succesfully.',
      setUp: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (realInvocation) async => Right(tMovieList),
        );
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(MovieListNowPlayingFetched()),
      expect: () => <MovieListState>[
        const MovieListState(nowPlayingMoviesState: RequestState.loading),
        MovieListState(
          nowPlayingMoviesState: RequestState.loaded,
          nowPlayingMovies: tMovieList,
        ),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()).called(1),
    );
    blocTest<MovieListBloc, MovieListState>(
      'emits a new failure message data when MovieListNowPlayingFetched is failure.',
      setUp: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
          (realInvocation) async => const Left(ServerFailure('Failure')),
        );
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(MovieListNowPlayingFetched()),
      expect: () => <MovieListState>[
        const MovieListState(nowPlayingMoviesState: RequestState.loading),
        const MovieListState(
          nowPlayingMoviesState: RequestState.error,
          message: 'Failure',
        ),
      ],
      verify: (bloc) => verify(mockGetNowPlayingMovies.execute()).called(1),
    );
  });
  group('Popular movies', () {
    test('Starting state should be empty', () {
      expect(movieListBloc.state.popularMoviesState, RequestState.empty);
    });
    blocTest<MovieListBloc, MovieListState>(
      'emits a new popularMovies data when MovieListPopularFetched is executed succesfully.',
      setUp: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (realInvocation) async => Right(tMovieList),
        );
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(MovieListPopularFetched()),
      expect: () => <MovieListState>[
        const MovieListState(popularMoviesState: RequestState.loading),
        MovieListState(
          popularMoviesState: RequestState.loaded,
          popularMovies: tMovieList,
        ),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()).called(1),
    );
    blocTest<MovieListBloc, MovieListState>(
      'emits a new failure message data when MovieListPopularFetched is failure.',
      setUp: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (realInvocation) async => const Left(ServerFailure('Failure')),
        );
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(MovieListPopularFetched()),
      expect: () => <MovieListState>[
        const MovieListState(popularMoviesState: RequestState.loading),
        const MovieListState(
          popularMoviesState: RequestState.error,
          message: 'Failure',
        ),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()).called(1),
    );
  });
  group('Top rated movies', () {
    test('Starting state should be empty', () {
      expect(movieListBloc.state.topRatedMoviesState, RequestState.empty);
    });
    blocTest<MovieListBloc, MovieListState>(
      'emits a new topRatedMovies data when MovieListTopRatedFetched is executed succesfully.',
      setUp: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (realInvocation) async => Right(tMovieList),
        );
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(MovieListTopRatedFetched()),
      expect: () => <MovieListState>[
        const MovieListState(topRatedMoviesState: RequestState.loading),
        MovieListState(
          topRatedMoviesState: RequestState.loaded,
          topRatedMovies: tMovieList,
        ),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()).called(1),
    );
    blocTest<MovieListBloc, MovieListState>(
      'emits a new failure message data when MovieListTopRatedFetched is failure.',
      setUp: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
          (realInvocation) async => const Left(ServerFailure('Failure')),
        );
      },
      build: () => movieListBloc,
      act: (bloc) => bloc.add(MovieListTopRatedFetched()),
      expect: () => <MovieListState>[
        const MovieListState(topRatedMoviesState: RequestState.loading),
        const MovieListState(
          topRatedMoviesState: RequestState.error,
          message: 'Failure',
        ),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()).called(1),
    );
  });
}
