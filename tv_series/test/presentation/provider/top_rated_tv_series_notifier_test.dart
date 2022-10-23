import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:core/presentation/provider/tv/top_rated_tv_series_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TopRatedTVSeriesNotifier provider;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
      provider = TopRatedTVSeriesNotifier(mockGetTopRatedTVSeries);
      provider.addListener(() {
        listenerCallCount += 1;
      });
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

  test('should change state to loading when usecase is called', () async {
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));

    provider.fetchTopRatedTVSeries();

    expect(provider.movieState, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change TV Series data when data is gotten successfully',
      () async {
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Right(tTVSeriesList));

    await provider.fetchTopRatedTVSeries();

    expect(provider.movieState, RequestState.loaded);
    expect(provider.tvSeries, tTVSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

    await provider.fetchTopRatedTVSeries();

    expect(provider.movieState, RequestState.error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
