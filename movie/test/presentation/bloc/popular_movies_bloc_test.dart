import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie_domain.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';

import 'mocks/popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMoviesBloc popularMoviesBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  setUp(
    () {
      mockGetPopularMovies = MockGetPopularMovies();
      popularMoviesBloc = PopularMoviesBloc(mockGetPopularMovies);
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

  group('Popular Movies', () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [state to loading and then change movies data and to loaded] when PopularMoviesFetched is added.',
      setUp: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((realInvocation) async => Right(tMovieList));
      },
      build: () => popularMoviesBloc,
      act: (bloc) => bloc.add(PopularMoviesFetched()),
      expect: () => <PopularMoviesState>[
        const PopularMoviesState(
          popularMoviesRequestState: RequestState.loading,
        ),
        PopularMoviesState(
          popularMoviesRequestState: RequestState.loaded,
          popularMovies: tMovieList,
        ),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()).called(1),
    );
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [state to empty with failure message] when PopularMoviesFetched is failed.',
      setUp: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (realInvocation) async => const Left(ServerFailure('Failure')));
      },
      build: () => popularMoviesBloc,
      act: (bloc) => bloc.add(PopularMoviesFetched()),
      expect: () => <PopularMoviesState>[
        const PopularMoviesState(
          popularMoviesRequestState: RequestState.loading,
        ),
        const PopularMoviesState(
          popularMoviesRequestState: RequestState.error,
          message: 'Failure',
        ),
      ],
      verify: (bloc) => verify(mockGetPopularMovies.execute()).called(1),
    );
  });
}
