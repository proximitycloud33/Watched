import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/usecases/tv/get_recommendation_tv_series.dart';
import 'package:core/presentation/provider/tv/recommendation_tv_series_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/recommendation_tv_series_notifer_test.mocks.dart';

@GenerateMocks([GetRecommendationTVSeries])
void main() {
  late MockGetRecommendationTVSeries mockGetRecommendationTVSeries;
  late RecommendationTVSeriesNotifier provider;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetRecommendationTVSeries = MockGetRecommendationTVSeries();
      provider = RecommendationTVSeriesNotifier(mockGetRecommendationTVSeries);
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
  const tId = 1;

  test('should change state to loading when usecase is called', () {
    when(mockGetRecommendationTVSeries.execute(tId))
        .thenAnswer((realInvocation) async => Right(tTVSeriesList));

    provider.fetchRecommendationTVSeries(tId);

    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });
  test('should change TVSeries data when data is gotten successfully',
      () async {
    when(mockGetRecommendationTVSeries.execute(tId))
        .thenAnswer((realInvocation) async => Right(tTVSeriesList));

    await provider.fetchRecommendationTVSeries(tId);

    expect(provider.tvSeriesRecommendation, tTVSeriesList);
    expect(listenerCallCount, 2);
  });
  test('should return error when data is unsuccessful', () async {
    when(mockGetRecommendationTVSeries.execute(tId)).thenAnswer(
        (realInvocation) async => Left(ServerFailure('Server Failure')));

    await provider.fetchRecommendationTVSeries(tId);

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
