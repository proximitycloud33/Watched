import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/movie_domain.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'mocks/movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late GetMovieDetail mockGetMovieDetail;
  late GetMovieRecommendations mockGetMovieRecommendations;
  setUp(
    () {
      mockGetMovieDetail = MockGetMovieDetail();
      mockGetMovieRecommendations = MockGetMovieRecommendations();
      movieDetailBloc =
          MovieDetailBloc(mockGetMovieDetail, mockGetMovieRecommendations);
    },
  );
  const testMovieDetail = MovieDetail(
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
  const tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
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
  const tMovieList = <Movie>[tMovieModel];
  const tId = 1;

  group('MovieDetail', () {
    test('Starting state should be empty', () {
      expect(movieDetailBloc.state, const MovieDetailState());
    });
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [loading and loaded state in movieState] when FetchMovieDetail is added.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
          (realInvocation) async => const Right(testMovieDetail),
        );
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => const <MovieDetailState>[
        MovieDetailState(movieState: RequestState.loading),
        MovieDetailState(
          movieState: RequestState.loaded,
          movie: testMovieDetail,
        )
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)).called(1),
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Error state in movieState] when FetchMovieDetail process is failure.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetail(tId)),
      expect: () => const <MovieDetailState>[
        MovieDetailState(movieState: RequestState.loading),
        MovieDetailState(
          movieState: RequestState.error,
          message: 'Server Failure',
        ),
      ],
      verify: (bloc) => verify(mockGetMovieDetail.execute(tId)).called(1),
    );
  });

  group('Movie Recommendation', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [loading and loaded state in MovieRecommendationState] when FetchRecommendation is added.',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((realInvocation) async => const Right(tMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendation(tId)),
      expect: () => const <MovieDetailState>[
        MovieDetailState(recommendationState: RequestState.loading),
        MovieDetailState(
          recommendationState: RequestState.loaded,
          movieRecommendations: tMovieList,
        ),
      ],
      verify: (bloc) =>
          verify(mockGetMovieRecommendations.execute(tId)).called(1),
    );
    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [Error state in movieState] when FetchRecommendation process is failure.',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchRecommendation(tId)),
      expect: () => const <MovieDetailState>[
        MovieDetailState(recommendationState: RequestState.loading),
        MovieDetailState(
          recommendationState: RequestState.error,
          message: 'Server Failure',
        ),
      ],
      verify: (bloc) =>
          verify(mockGetMovieRecommendations.execute(tId)).called(1),
    );
  });
}
