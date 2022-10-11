import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

import '../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SearchTVSeries(repository: mockTVSeriesRepository);
  });

  final testTVSeries = <TVSeries>[];
  const testQuery = 'Rick';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.searchTVSeries(testQuery))
        .thenAnswer((_) async => Right(testTVSeries));
    // act
    final result = await usecase.execute(testQuery);
    // assert
    expect(result, Right(testTVSeries));
  });
}
