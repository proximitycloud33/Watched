import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(
    () {
      mockTVSeriesRepository = MockTVSeriesRepository();
      usecase = GetTopRatedTVSeries(repository: mockTVSeriesRepository);
    },
  );
  final tTVSeries = <TVSeries>[];

  test('should get list of on the air TV Series from repository', () async {
    when(mockTVSeriesRepository.getTopRatedTVSeries())
        .thenAnswer((realInvocation) async => Right(tTVSeries));
    final result = await usecase.execute();
    expect(result, Right(tTVSeries));
  });
}
