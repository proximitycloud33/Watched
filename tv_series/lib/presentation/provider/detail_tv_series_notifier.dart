import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

class DetailTVSeriesNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetDetailTVSeries getDetailTVSeries;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  late TVSeriesDetail _tvSeriesDetail;
  RequestState _tvSeriesState = RequestState.empty;
  String _message = '';
  bool _isAddedToWatchlist = false;
  String _watchlistMessage = '';

  DetailTVSeriesNotifier({
    required this.getDetailTVSeries,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  bool get isAddedToWatchlist => _isAddedToWatchlist;
  String get message => _message;
  RequestState get tvSeriesState => _tvSeriesState;
  TVSeriesDetail get tvSeriesDetail => _tvSeriesDetail;
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTVSeriesDetail(int id) async {
    _tvSeriesState = RequestState.loading;
    notifyListeners();
    final detailResult = await getDetailTVSeries.execute(id);
    detailResult.fold((failure) {
      _tvSeriesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesDetail) {
      _tvSeriesState = RequestState.loaded;
      _tvSeriesDetail = tvSeriesDetail;
      notifyListeners();
    });
  }

  Future<void> addWatchlist(Watchlist watchlist) async {
    final result = await saveWatchlist.execute(watchlist);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(watchlist.id);
  }

  Future<void> removeFromWatchlist(Watchlist watchlist) async {
    final result = await removeWatchlist.execute(watchlist);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(watchlist.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final watchlistResult = await getWatchListStatus.execute(id);
    _isAddedToWatchlist = watchlistResult;
    notifyListeners();
  }
}
