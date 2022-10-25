import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie_domain.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';

import 'mocks/top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMoviesBloc topRatedMoviesBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  setUp(
    () {
      mockGetTopRatedMovies = MockGetTopRatedMovies();
      topRatedMoviesBloc = TopRatedMoviesBloc(mockGetTopRatedMovies);
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

  group('Top Rated Movies', () {
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'emits [state to loading and then change movies data and to loaded] when TopRatedMoviesFetched is added.',
      setUp: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
      },
      build: () => topRatedMoviesBloc,
      act: (bloc) => bloc.add(TopRatedMoviesFetched()),
      expect: () => <TopRatedMoviesState>[
        const TopRatedMoviesState(
          topRatedMoviesRequestState: RequestState.loading,
        ),
        TopRatedMoviesState(
          topRatedMoviesRequestState: RequestState.loaded,
          topRatedMovies: tMovieList,
        ),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()).called(1),
    );
    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'emits [state to empty with failure message] when PopularMoviesFetched is failed.',
      setUp: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (realInvocation) async => const Left(ServerFailure('Failure')));
      },
      build: () => topRatedMoviesBloc,
      act: (bloc) => bloc.add(TopRatedMoviesFetched()),
      expect: () => <TopRatedMoviesState>[
        const TopRatedMoviesState(
          topRatedMoviesRequestState: RequestState.loading,
        ),
        const TopRatedMoviesState(
          topRatedMoviesRequestState: RequestState.error,
          message: 'Failure',
        ),
      ],
      verify: (bloc) => verify(mockGetTopRatedMovies.execute()).called(1),
    );
  });
}
