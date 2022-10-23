import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/tv/search_bloc.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import 'search_tv_series_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesBloc searchBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(
    () {
      mockSearchTVSeries = MockSearchTVSeries();
      searchBloc = SearchTVSeriesBloc(mockSearchTVSeries);
    },
  );
  const testTVSeriesModel = TVSeries(
    backdropPath: 'path',
    firstAirDate: 'date',
    genreIds: [4, 2, 0],
    id: 42,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'oriName',
    overview: 'overview',
    popularity: 42,
    posterPath: 'path',
    name: 'name',
    voteAverage: 4,
    voteCount: 2,
  );
  final testTVSeriesList = <TVSeries>[testTVSeriesModel];
  const tQuery = 'query';
  group('TV Series bloc test', () {
    test('initial state should be empty', () {
      expect(searchBloc.state, SearchEmpty());
    });
    blocTest<SearchTVSeriesBloc, SearchState>(
      'emits [Loading, hasData] when data is gotten.',
      build: () {
        when(mockSearchTVSeries.execute(tQuery))
            .thenAnswer((realInvocation) async => Right(testTVSeriesList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => <SearchState>[
        SearchLoading(),
        SearchHasData(testTVSeriesList),
      ],
      verify: (bloc) => verify(mockSearchTVSeries.execute(tQuery)),
    );
    blocTest<SearchTVSeriesBloc, SearchState>(
      'emits [SearchLoading, SearchError] when there is exception.',
      build: () {
        when(mockSearchTVSeries.execute(tQuery)).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => <SearchState>[
        SearchLoading(),
        const SearchError('Server Failure'),
      ],
      verify: (bloc) => verify(mockSearchTVSeries.execute(tQuery)),
    );
  });
}
