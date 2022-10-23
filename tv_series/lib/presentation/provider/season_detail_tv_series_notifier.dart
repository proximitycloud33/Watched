import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_season_detail_tv_series.dart';

class SeasonDetailTVSeriesNotifier extends ChangeNotifier {
  final GetSeasonDetailTVSeries getSeasonDetailTVSeries;

  TVSeriesSeasonDetail? _tvSeriesSeasonDetail;
  RequestState _state = RequestState.empty;
  String _message = '';

  SeasonDetailTVSeriesNotifier(this.getSeasonDetailTVSeries);

  String get message => _message;
  RequestState get state => _state;
  TVSeriesSeasonDetail? get tvSeriesSeasonDetail => _tvSeriesSeasonDetail;

  Future<void> fetchTVSeriesSeasonDetail(int id, int season) async {
    _state = RequestState.loading;
    notifyListeners();

    final detailResult = await getSeasonDetailTVSeries.execute(id, season);
    detailResult.fold((failure) {
      _state = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesSeasonDetail) {
      _state = RequestState.loaded;
      _tvSeriesSeasonDetail = tvSeriesSeasonDetail;
      notifyListeners();
    });
  }
}
