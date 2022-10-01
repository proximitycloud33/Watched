import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/tv/list_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/list_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTVSeries, GetPopularTVSeries, GetTopRatedTVSeries])
void main() {
  late ListTVSeriesNotifier provider;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
      mockGetPopularTVSeries = MockGetPopularTVSeries();
      mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
      provider = ListTVSeriesNotifier(
        getOnTheAirTVSeries: mockGetOnTheAirTVSeries,
        getPopularTVSeries: mockGetPopularTVSeries,
        getTopRatedTVSeries: mockGetTopRatedTVSeries,
      )..addListener(() {
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
  group('On The Air TV Series', () {
    test('Starting state should be empty', () {
      expect(provider.onTheAirTVSeriesState, RequestState.Empty);
    });
    test('Should get data from the usecase', () {
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      provider.fetchOnTheAirTVSeries();

      verify(mockGetOnTheAirTVSeries.execute());
    });
    test('should change state to Loading state when usecase is executed', () {
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      provider.fetchOnTheAirTVSeries();
      expect(provider.onTheAirTVSeriesState, RequestState.Loading);
    });
    test('should change TV Series when data is gotten succefully', () async {
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      await provider.fetchOnTheAirTVSeries();

      expect(provider.onTheAirTVSeriesState, RequestState.Loaded);
      expect(provider.onTheAirTVSeries, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when fetching data is unsuccessful', () async {
      when(mockGetOnTheAirTVSeries.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));

      await provider.fetchOnTheAirTVSeries();

      expect(provider.onTheAirTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Popular TV Series', () {
    test('Starting state should be empty', () {
      expect(provider.popularTVSeriesState, RequestState.Empty);
    });
    test('Should get data from the usecase', () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      provider.fetchPopularTVSeries();

      verify(mockGetPopularTVSeries.execute());
    });
    test('should change state to Loading state when usecase is executed',
        () async {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      provider.fetchPopularTVSeries();
      expect(provider.popularTVSeriesState, RequestState.Loading);
    });
    test('should change TV Series when data is gotten succefully', () async {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      await provider.fetchPopularTVSeries();

      expect(provider.popularTVSeriesState, RequestState.Loaded);
      expect(provider.popularTVSeries, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when fetching data is unsuccessful', () async {
      when(mockGetPopularTVSeries.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));

      await provider.fetchPopularTVSeries();

      expect(provider.popularTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  group('Top Rated TV Series', () {
    test('Starting state should be empty', () {
      expect(provider.topRatedTVSeriesState, RequestState.Empty);
    });
    test('Should get data from the usecase', () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      provider.fetchTopRatedTVSeries();

      verify(mockGetTopRatedTVSeries.execute());
    });
    test('should change state to Loading state when usecase is executed',
        () async {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      provider.fetchTopRatedTVSeries();
      expect(provider.topRatedTVSeriesState, RequestState.Loading);
    });
    test('should change TV Series data when data is gotten succefully',
        () async {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((realInvocation) async => Right(tTVSeriesList));

      await provider.fetchTopRatedTVSeries();

      expect(provider.topRatedTVSeriesState, RequestState.Loaded);
      expect(provider.topRatedTVSeries, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when fetching data is unsuccessful', () async {
      when(mockGetTopRatedTVSeries.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedTVSeries();

      expect(provider.topRatedTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
