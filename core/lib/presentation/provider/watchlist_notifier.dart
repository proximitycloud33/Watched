import '../../common/state_enum.dart';
import '../../domain/entities/watchlist.dart';
import '../../domain/usecases/watchlist/get_watchlist.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlist = <Watchlist>[];
  List<Watchlist> get watchlist => _watchlist;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistNotifier({required this.getWatchlistMovies});

  final GetWatchlist getWatchlistMovies;

  Future<void> fetchWatchlist() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlist) {
        _watchlistState = RequestState.Loaded;
        _watchlist = watchlist;
        notifyListeners();
      },
    );
  }
}
