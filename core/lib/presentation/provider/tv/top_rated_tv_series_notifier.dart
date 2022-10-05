import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv_series.dart';
import '../../../domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:flutter/foundation.dart';

class TopRatedTVSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTVSeries getTopRatedTVSeries;

  RequestState _state = RequestState.Empty;

  List<TVSeries> _tvSeries = [];
  String _message = '';

  TopRatedTVSeriesNotifier(this.getTopRatedTVSeries);

  String get message => _message;
  List<TVSeries> get tvSeries => _tvSeries;
  RequestState get state => _state;

  Future<void> fetchTopRatedTVSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeries = tvSeries;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
