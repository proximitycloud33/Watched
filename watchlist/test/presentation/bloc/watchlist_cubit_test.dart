import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/watchlist_domain.dart';
import '../../dummy_objects.dart';
import 'watchlist_cubit_test.mocks.dart';

@GenerateMocks([
  GetWatchlist,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistCubit watchlistCubit;
  late GetWatchlist mockGetWatchlist;
  late GetWatchListStatus mockGetWatchlistStatus;
  late SaveWatchlist mockSaveWatchlist;
  late RemoveWatchlist mockRemoveWatchlist;

  setUp(
    () {
      mockGetWatchlist = MockGetWatchlist();
      mockGetWatchlistStatus = MockGetWatchListStatus();
      mockSaveWatchlist = MockSaveWatchlist();
      mockRemoveWatchlist = MockRemoveWatchlist();
      watchlistCubit = WatchlistCubit(
        mockGetWatchlist,
        mockGetWatchlistStatus,
        mockSaveWatchlist,
        mockRemoveWatchlist,
      );
    },
  );
  const tId = 1;
  group('Watchlist', () {
    blocTest<WatchlistCubit, WatchlistState>(
      'emits a list of [Watchlist] and change state to loaded  when FetchWatchlist is executed.',
      setUp: () {
        when(mockGetWatchlist.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlist]));
      },
      build: () => watchlistCubit,
      act: (cubit) => cubit.fetchWatchlist(),
      expect: () => <WatchlistState>[
        const WatchlistState(watchlistRequestState: RequestState.loading),
        WatchlistState(
          watchlistRequestState: RequestState.loaded,
          watchlist: [testWatchlist],
        ),
      ],
      verify: (cubit) => verify(mockGetWatchlist.execute()).called(1),
    );
    blocTest<WatchlistCubit, WatchlistState>(
      'emits [true] when loadWatchlistStatus is executed.',
      setUp: () {
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((realInvocation) async => true);
      },
      build: () => watchlistCubit,
      act: (cubit) => cubit.loadWatchlistStatus(tId),
      expect: () => <WatchlistState>[
        const WatchlistState(isAddedToWatchList: true),
      ],
      verify: (cubit) => verify(mockGetWatchlistStatus.execute(tId)).called(1),
    );
    blocTest<WatchlistCubit, WatchlistState>(
        'emits a new watchlist message and change is addedToWatchList to true and load watchlist status when addWatchlist is executed.',
        setUp: () {
          when(mockSaveWatchlist.execute(testWatchlist))
              .thenAnswer((realInvocation) async => const Right('Success'));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((realInvocation) async => true);
        },
        build: () => watchlistCubit,
        act: (cubit) => cubit.addWatchlist(testWatchlist),
        expect: () => <WatchlistState>[
              const WatchlistState(watchlistMessage: 'Added to Watchlist'),
              const WatchlistState(
                watchlistMessage: 'Added to Watchlist',
                isAddedToWatchList: true,
              ),
            ],
        verify: (cubit) {
          verify(mockSaveWatchlist.execute(testWatchlist)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });
    blocTest<WatchlistCubit, WatchlistState>(
        'emits a new watchlist message and change is addedToWatchList to false and load watchlist status when RemoveFromWatchlist is executed.',
        setUp: () {
          when(mockRemoveWatchlist.execute(testWatchlist))
              .thenAnswer((realInvocation) async => const Right('Success'));
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((realInvocation) async => false);
        },
        build: () => watchlistCubit,
        act: (cubit) => cubit.removeFromWatchlist(testWatchlist),
        expect: () => <WatchlistState>[
              const WatchlistState(watchlistMessage: 'Removed from Watchlist'),
            ],
        verify: (cubit) {
          verify(mockRemoveWatchlist.execute(testWatchlist)).called(1);
          verify(mockGetWatchlistStatus.execute(tId)).called(1);
        });
  });
}
