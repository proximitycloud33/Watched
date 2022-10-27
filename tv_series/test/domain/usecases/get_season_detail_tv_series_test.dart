import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_season_detail_tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetailTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetSeasonDetailTVSeries(repository: mockTVSeriesRepository);
  });

  const testId = 1;
  const testSeason = 1;
  const testTVSeriesSeasonDetail = TVSeriesSeasonDetail(
    airDate: '2022-08-01',
    episodes: [
      Episode(
        airDate: '2022-08-01',
        episodeNumber: 1,
        id: 1,
        showId: 1,
        name: 'Never',
        overview: 'Gonna',
        productionCode: 'Give',
        runtime: 60,
        seasonNumber: 1,
        stillPath: '/youUp.jpg',
        voteAverage: 4.1,
        voteCount: 420,
      ),
    ],
    id: '1',
    name: 'Rick Astley',
    overview: 'You are no stranger to love',
    posterPath: '/path',
    purpleId: 1,
    seasonNumber: 1,
  );

  test('should get season detail from the repository', () async {
    // arrange
    when(mockTVSeriesRepository.getSeasonDetailTVSeries(testId, testSeason))
        .thenAnswer((_) async => const Right(testTVSeriesSeasonDetail));
    // act
    final result = await usecase.execute(testId, testSeason);
    // assert
    expect(result, const Right(testTVSeriesSeasonDetail));
  });
}
