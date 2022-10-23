import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/watchlist_domain.dart';

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
  late RemoveWatchlist removeWatchlist;
  setUp(
    () {
      watchlistCubit = WatchlistCubit(_getWatchListStatus, _saveWatchlist, _removeWatchlist)
    },
  );
}
