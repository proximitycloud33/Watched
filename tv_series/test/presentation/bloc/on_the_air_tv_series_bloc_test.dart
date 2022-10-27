import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tv_series_bloc/on_the_air_tv_series_bloc.dart';

import 'mocks/on_the_air_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTVSeries])
void main() {
  late OnTheAirTVSeriesBloc onTheAirTVSeriesBloc;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;

  setUp(
    () {
      mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
      onTheAirTVSeriesBloc = OnTheAirTVSeriesBloc(mockGetOnTheAirTVSeries);
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
  group('OnTheAir TVSeries', () {
    blocTest<OnTheAirTVSeriesBloc, OnTheAirTVSeriesState>(
      'emits [state to loading and then change TV Series data and to loaded] when OnTheAirTVSeriesFetched is added.',
      setUp: () {
        when(mockGetOnTheAirTVSeries.execute())
            .thenAnswer((realInvocation) async => Right(tTVSeriesList));
      },
      build: () => onTheAirTVSeriesBloc,
      act: (bloc) => bloc.add(const OnTheAirTVSeriesFetched()),
      expect: () => <OnTheAirTVSeriesState>[
        const OnTheAirTVSeriesState(
            onTheAirTVSeriesRequestState: RequestState.loading),
        OnTheAirTVSeriesState(
          onTheAirTVSeriesRequestState: RequestState.loaded,
          onTheAirTVSeries: tTVSeriesList,
        ),
      ],
    );
    blocTest<OnTheAirTVSeriesBloc, OnTheAirTVSeriesState>(
      'emits [state to empty with failure message] when OnTheAirTVSeriesFetched is added and failed.',
      setUp: () {
        when(mockGetOnTheAirTVSeries.execute()).thenAnswer(
            (realInvocation) async =>
                const Left(ServerFailure('Server Failure')));
      },
      build: () => onTheAirTVSeriesBloc,
      act: (bloc) => bloc.add(const OnTheAirTVSeriesFetched()),
      expect: () => <OnTheAirTVSeriesState>[
        const OnTheAirTVSeriesState(
            onTheAirTVSeriesRequestState: RequestState.loading),
        const OnTheAirTVSeriesState(
          onTheAirTVSeriesRequestState: RequestState.error,
          message: 'Server Failure',
        ),
      ],
    );
  });
}
