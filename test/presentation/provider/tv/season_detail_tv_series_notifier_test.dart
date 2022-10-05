import 'package:dartz/dartz.dart';
import '../../../../core/lib/common/failure.dart';
import '../../../../core/lib/common/state_enum.dart';
import '../../../../core/lib/domain/entities/tv/episode.dart';
import '../../../../core/lib/domain/entities/tv/tv_series_season_detail.dart';
import '../../../../core/lib/domain/usecases/tv/get_season_detail_tv_series.dart';
import '../../../../core/lib/presentation/provider/tv/season_detail_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/season_detail_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetSeasonDetailTVSeries])
void main() {
  late MockGetSeasonDetailTVSeries mockGetSeasonDetailTVSeries;
  late SeasonDetailTVSeriesNotifier provider;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetSeasonDetailTVSeries = MockGetSeasonDetailTVSeries();
      provider = SeasonDetailTVSeriesNotifier(mockGetSeasonDetailTVSeries);
      provider.addListener(() {
        listenerCallCount += 1;
      });
    },
  );
  final testTVSeriesSeasonDetail = TVSeriesSeasonDetail(
    airDate: "2022-08-21",
    episodes: [
      Episode(
        airDate: "2022-08-21",
        episodeNumber: 1,
        id: 1971015,
        name: "The Heirs of the Dragon",
        overview:
            "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
        productionCode: "",
        runtime: 66,
        seasonNumber: 1,
        showId: 94997,
        stillPath: "/7gHqMO96iyTEBh6fCL3GUHxbhKZ.jpg",
        voteAverage: 8,
        voteCount: 57,
      ),
    ],
    name: "Season 1",
    id: "5db952cca1d3320014e91171",
    purpleId: 134965,
    posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
    overview: "",
    seasonNumber: 1,
  );
  final testId = 1;
  final testSeason = 1;

  test('should change state to loading when usecase is called', () {
    when(mockGetSeasonDetailTVSeries.execute(testId, testSeason))
        .thenAnswer((realInvocation) async => Right(testTVSeriesSeasonDetail));

    provider.fetchTVSeriesSeasonDetail(testId, testSeason);

    expect(provider.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });
  test(
      'Should change TV Series Season Detail data when data is succesfully gotten',
      () async {
    when(mockGetSeasonDetailTVSeries.execute(testId, testSeason))
        .thenAnswer((realInvocation) async => Right(testTVSeriesSeasonDetail));

    await provider.fetchTVSeriesSeasonDetail(testId, testSeason);

    expect(provider.state, RequestState.Loaded);
    expect(provider.tvSeriesSeasonDetail, testTVSeriesSeasonDetail);
    expect(listenerCallCount, 2);
  });
  test('Should return error', () async {
    when(mockGetSeasonDetailTVSeries.execute(testId, testSeason)).thenAnswer(
        (realInvocation) async => Left(ServerFailure('Server Failure')));

    await provider.fetchTVSeriesSeasonDetail(testId, testSeason);

    expect(provider.state, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
