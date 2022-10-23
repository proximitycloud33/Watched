import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';

class OnTheAirTVSeriesNotifier extends ChangeNotifier {
  final GetOnTheAirTVSeries getOnTheAirTVSeries;

  RequestState _state = RequestState.empty;
  List<TVSeries> _tvSeries = [];
  String _message = '';

  OnTheAirTVSeriesNotifier(this.getOnTheAirTVSeries);

  String get message => _message;
  List<TVSeries> get tvSeries => _tvSeries;
  RequestState get state => _state;

  Future<void> fetchOnTheAirTVSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTVSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeries = tvSeries;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
