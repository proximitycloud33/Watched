import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie/search_bloc.dart';

import 'search_movies_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMoviesBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  setUp(
    () {
      mockSearchMovies = MockSearchMovies();
      searchBloc = SearchMoviesBloc(mockSearchMovies);
    },
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
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });
  blocTest<SearchMoviesBloc, SearchState>(
    'emits [Loading, HasData] when data is Gotten.',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((realInvocation) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => <SearchState>[
      SearchLoading(),
      SearchHasData(tMovieList),
    ],
    verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
  );
  blocTest<SearchMoviesBloc, SearchState>(
    'emits [SearchLoading, SearchError] when there is exception.',
    build: () {
      when(mockSearchMovies.execute(tQuery)).thenAnswer(
          (realInvocation) async =>
              const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    wait: const Duration(milliseconds: 500),
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    expect: () =>
        <SearchState>[SearchLoading(), const SearchError('Server Failure')],
    verify: (bloc) => verify(mockSearchMovies.execute(tQuery)),
  );
}
