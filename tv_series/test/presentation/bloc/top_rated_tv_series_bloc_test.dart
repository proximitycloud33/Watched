import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';

import 'mocks/top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late TopRatedTVSeriesBloc topRatedTVSeriesBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(
    () {
      mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
      topRatedTVSeriesBloc = TopRatedTVSeriesBloc(mockGetTopRatedTVSeries);
    },
  );
  const tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalname',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'first',
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVSeriesList = <TVSeries>[tTVSeries];

  group('Top Rated TVSeries', () {
    blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'emits [state to loading and then change tv series data and to loaded] when TopRatedTVSeriesFetched is added.',
      setUp: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => topRatedTVSeriesBloc,
      act: (bloc) => bloc.add(const TopRatedTVSeriesFetched()),
      expect: () => <TopRatedTVSeriesState>[
        const TopRatedTVSeriesState(
          topRatedTVSeriesRequestState: RequestState.loading,
        ),
        TopRatedTVSeriesState(
          topRatedTVSeriesRequestState: RequestState.loaded,
          topRatedTVSeries: tTVSeriesList,
        ),
      ],
    );
    blocTest<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
      'emits [state to empty with failure message] when TopRatedTVSeriesFetched is failed.',
      setUp: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (realInvocation) async => const Left(ServerFailure('Failure')));
      },
      build: () => topRatedTVSeriesBloc,
      act: (bloc) => bloc.add(const TopRatedTVSeriesFetched()),
      expect: () => <TopRatedTVSeriesState>[
        const TopRatedTVSeriesState(
          topRatedTVSeriesRequestState: RequestState.loading,
        ),
        const TopRatedTVSeriesState(
          topRatedTVSeriesRequestState: RequestState.error,
          message: 'Failure',
        ),
      ],
    );
  });
}
