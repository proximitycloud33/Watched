import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/on_the_air_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/on_the_air_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTVSeries])
void main() {
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;
  late OnTheAirTVSeriesNotifier provider;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
      provider = OnTheAirTVSeriesNotifier(mockGetOnTheAirTVSeries);
      provider.addListener(() {
        listenerCallCount += 1;
      });
    },
  );

  final tTVSeries = TVSeries(
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
  test('should change state to loading when usecase is called', () async {
    when(mockGetOnTheAirTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));

    provider.fetchOnTheAirTVSeries();

    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change TV Series data when data is gotten successfully',
      () async {
    when(mockGetOnTheAirTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));

    await provider.fetchOnTheAirTVSeries();

    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeries, tTVSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetOnTheAirTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

    await provider.fetchOnTheAirTVSeries();

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
