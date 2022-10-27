import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_season_detail_tv_series.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series_bloc/season_detail_tv_series_bloc.dart';

import 'mocks/season_detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetSeasonDetailTVSeries])
void main() {
  late SeasonDetailTVSeriesBloc seasonDetailTVSeriesBloc;
  late MockGetSeasonDetailTVSeries mockGetSeasonDetailTVSeries;

  setUp(
    () {
      mockGetSeasonDetailTVSeries = MockGetSeasonDetailTVSeries();
      seasonDetailTVSeriesBloc =
          SeasonDetailTVSeriesBloc(mockGetSeasonDetailTVSeries);
    },
  );
  const testTVSeriesSeasonDetail = TVSeriesSeasonDetail(
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
  const testId = 1;
  const testSeason = 1;

  group('Season Detail TVSeries', () {
    blocTest<SeasonDetailTVSeriesBloc, SeasonDetailTVSeriesState>(
      'emits [state to loading and then change tv series detail data and change to loaded] when SeasonDetailFetched is added.',
      setUp: () {
        when(mockGetSeasonDetailTVSeries.execute(testId, testSeason))
            .thenAnswer(
          (realInvocation) async => const Right(testTVSeriesSeasonDetail),
        );
      },
      build: () => seasonDetailTVSeriesBloc,
      act: (bloc) => bloc.add(
          const SeasonDetailTVSeriesFetched(id: testId, season: testSeason)),
      expect: () => const <SeasonDetailTVSeriesState>[
        SeasonDetailTVSeriesState(seasonDetailState: RequestState.loading),
        SeasonDetailTVSeriesState(
          seasonDetailState: RequestState.loaded,
          tvSeriesSeasonDetail: testTVSeriesSeasonDetail,
        ),
      ],
    );
    blocTest<SeasonDetailTVSeriesBloc, SeasonDetailTVSeriesState>(
      'emits [state to empty with failure message] when SeasonDetailTVSeriesFetched is failed.',
      setUp: () {
        when(mockGetSeasonDetailTVSeries.execute(testId, testSeason))
            .thenAnswer(
          (realInvocation) async => const Right(testTVSeriesSeasonDetail),
        );
      },
      build: () => seasonDetailTVSeriesBloc,
      act: (bloc) => bloc.add(
          const SeasonDetailTVSeriesFetched(id: testId, season: testSeason)),
      expect: () => const <SeasonDetailTVSeriesState>[
        SeasonDetailTVSeriesState(seasonDetailState: RequestState.loading),
        SeasonDetailTVSeriesState(
          seasonDetailState: RequestState.loaded,
          tvSeriesSeasonDetail: testTVSeriesSeasonDetail,
        ),
      ],
    );
  });
}
