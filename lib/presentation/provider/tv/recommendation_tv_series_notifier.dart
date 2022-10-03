import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_recommendation_tv_series.dart';
import 'package:flutter/foundation.dart';

class RecommendationTVSeriesNotifier extends ChangeNotifier {
  final GetRecommendationTVSeries getRecommendationTVSeries;

  RequestState _state = RequestState.Empty;
  List<TVSeries> _tvSeries = [];
  String _message = '';

  RecommendationTVSeriesNotifier(this.getRecommendationTVSeries);

  String get message => _message;
  RequestState get state => _state;
  List<TVSeries> get tvSeriesRecommendation => _tvSeries;

  Future<void> fetchRecommendationTVSeries(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getRecommendationTVSeries.execute(id);

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
