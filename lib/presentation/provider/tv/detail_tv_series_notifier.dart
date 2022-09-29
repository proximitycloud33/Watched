import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_detail_tv_series.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist_status.dart';
import 'package:flutter/foundation.dart';

class DetailTVSeriesNotifier extends ChangeNotifier {
  final GetDetailTVSeries getDetailTVSeries;
  final GetWatchListStatus getWatchListStatus;

  late TVSeriesDetail _tvSeriesDetail;
  RequestState _tvSeriesState = RequestState.Empty;
  String _message = '';
  bool _isAddedtoWatchlist = false;

  DetailTVSeriesNotifier({
    required this.getDetailTVSeries,
    required this.getWatchListStatus,
  });

  bool get isAddedtoWatchlist => _isAddedtoWatchlist;
  String get message => _message;
  RequestState get state => _tvSeriesState;
  TVSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  Future<void> fetchTVSeriesDetail(int id) async {
    final detailResult = await getDetailTVSeries.execute(id);
    detailResult.fold((failure) {
      _tvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesDetail) {
      _tvSeriesState = RequestState.Loaded;
      _tvSeriesDetail = tvSeriesDetail;
      notifyListeners();
    });
  }

  Future<void> loadWatchlistStatus(int id) async {
    final watchlistResult = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = watchlistResult;
    notifyListeners();
  }
}
