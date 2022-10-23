import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';

class RecommendationTVSeriesNotifier extends ChangeNotifier {
  final GetRecommendationTVSeries getRecommendationTVSeries;

  RequestState _state = RequestState.empty;
  List<TVSeries> _tvSeries = [];
  String _message = '';

  RecommendationTVSeriesNotifier(this.getRecommendationTVSeries);

  String get message => _message;
  RequestState get state => _state;
  List<TVSeries> get tvSeriesRecommendation => _tvSeries;

  Future<void> fetchRecommendationTVSeries(int id) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getRecommendationTVSeries.execute(id);

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
