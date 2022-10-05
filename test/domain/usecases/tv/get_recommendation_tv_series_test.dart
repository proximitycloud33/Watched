import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import '../../../../core/lib/domain/usecases/tv/get_recommendation_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(
    () {
      mockTVSeriesRepository = MockTVSeriesRepository();
      usecase = GetRecommendationTVSeries(repository: mockTVSeriesRepository);
    },
  );
  final testId = 1;
  final tTVSeries = <TVSeries>[];

  test('should get list of TV Series from repository', () async {
    when(mockTVSeriesRepository.getRecommendationTVSeries(testId))
        .thenAnswer((realInvocation) async => Right(tTVSeries));
    final result = await usecase.execute(testId);
    expect(result, Right(tTVSeries));
  });
}
