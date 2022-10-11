import 'package:core/domain/usecases/watchlist/get_watchlist.dart';
import '../../../../../watchlist/lib/presentation/provider/watchlist_notifier.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'mocks/watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlist mockGetWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlist = MockGetWatchlist();
    provider = WatchlistNotifier(
      getWatchlistMovies: mockGetWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => Right([testWatchlist]));
    // act
    await provider.fetchWatchlist();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlist, [testWatchlist]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlist();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
