import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/episode.dart';
import 'package:ditonton/domain/entities/tv/tv_series_season_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_season_detail_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetSeasonDetailTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = GetSeasonDetailTVSeries(mockTVSeriesRepository);
  });

  final testId = 1;
  final testSeason = 1;
  final testTVSeriesSeasonDetail = TVSeriesSeasonDetail(
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
        .thenAnswer((_) async => Right(testTVSeriesSeasonDetail));
    // act
    final result = await usecase.execute(testId, testSeason);
    // assert
    expect(result, Right(testTVSeriesSeasonDetail));
  });
}
