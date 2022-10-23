import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/season.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import '../../../../../watchlist/lib/entity/watchlist.dart';
import 'package:core/domain/usecases/tv/get_detail_tv_series.dart';
import 'package:core/domain/usecases/watchlist/get_watchlist_status.dart';
import 'package:core/domain/usecases/watchlist/remove_watchlist.dart';
import 'package:core/domain/usecases/watchlist/save_watchlist.dart';
import 'package:core/presentation/provider/tv/detail_tv_series_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks/detail_tv_series_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTVSeries,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late DetailTVSeriesNotifier provider;
  late MockGetDetailTVSeries mockGetDetailTVSeries;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetDetailTVSeries = MockGetDetailTVSeries();
      mockGetWatchlistStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      provider = DetailTVSeriesNotifier(
        getDetailTVSeries: mockGetDetailTVSeries,
        getWatchListStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist,
      )..addListener(() {
          listenerCallCount += 1;
        });
    },
  );
  const testId = 1;

  final tTVSeriesDetail = TVSeriesDetail(
    adult: false,
    firstAirDate: '2022-08-21',
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'Dragon',
    originalName: 'House of Dragon',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    seasons: [
      Season(
        airDate: '2022-08-21',
        episodeCount: 10,
        id: 1,
        name: 'Dragon',
        overview: '',
        posterPath: '',
        seasonNumber: 1,
      )
    ],
    voteAverage: 1,
    voteCount: 1,
  );
  final testWatchlist = Watchlist(
    id: 1,
    type: 'tv',
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  void _arrangeUsecase() {
    when(mockGetDetailTVSeries.execute(testId))
        .thenAnswer((realInvocation) async => Right(tTVSeriesDetail));
  }

  group('Get TVSeries Detail', () {
    test('should get data from the bussiness logic usecase', () async {
      _arrangeUsecase();
      await provider.fetchTVSeriesDetail(testId);

      verify(mockGetDetailTVSeries.execute(testId));
    });
    test('should change state to Loading when usecase is called', () async {
      _arrangeUsecase();
      provider.fetchTVSeriesDetail(testId);
      expect(provider.tvSeriesState, RequestState.loading);
      expect(listenerCallCount, 1);
    });
    test('should change TVSeries when data is gotten', () async {
      _arrangeUsecase();
      await provider.fetchTVSeriesDetail(testId);
      expect(provider.tvSeriesState, RequestState.loaded);
      expect(provider.tvSeriesDetail, tTVSeriesDetail);
      expect(listenerCallCount, 2);
    });
    test('should return error when Request state is error', () async {
      when(mockGetDetailTVSeries.execute(testId)).thenAnswer(
          (realInvocation) async => const Left(ServerFailure('Failed')));
      await provider.fetchTVSeriesDetail(testId);
      expect(provider.tvSeriesState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get watchlist status', () async {
      when(mockGetWatchlistStatus.execute(testId)).thenAnswer(
        (realInvocation) async => true,
      );
      await provider.loadWatchlistStatus(testId);
      expect(provider.isAddedToWatchlist, isTrue);
    });
    test('should execute save watchlist when function is called', () async {
      when(mockSaveWatchlist.execute(testWatchlist))
          .thenAnswer((realInvocation) async => const Right('Success'));
      when(mockGetWatchlistStatus.execute(tTVSeriesDetail.id))
          .thenAnswer((realInvocation) async => true);

      await provider.addWatchlist(testWatchlist);

      verify(mockSaveWatchlist.execute(testWatchlist));
      expect(provider.watchlistMessage, 'Success');
    });
    test('should execute remove watchlist when function is called', () async {
      when(mockRemoveWatchlist.execute(testWatchlist))
          .thenAnswer((realInvocation) async => const Right('Removed'));
      when(mockGetWatchlistStatus.execute(tTVSeriesDetail.id))
          .thenAnswer((realInvocation) async => false);

      await provider.removeFromWatchlist(testWatchlist);

      verify(mockRemoveWatchlist.execute(testWatchlist));
    });
    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testWatchlist))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(tTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testWatchlist);
      // assert
      verify(mockGetWatchlistStatus.execute(tTVSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });
  });
}
