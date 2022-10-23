import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

class ListTVSeriesNotifier extends ChangeNotifier {
  var _onTheAirTVSeries = <TVSeries>[];
  var _popularTVSeries = <TVSeries>[];
  var _topRatedTVSeries = <TVSeries>[];

  String _message = '';

  RequestState _onTheAirTVSeriesState = RequestState.empty;
  RequestState _popularTVSeriesState = RequestState.empty;
  RequestState _topRatedTVSeriesState = RequestState.empty;

  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  ListTVSeriesNotifier({
    required this.getOnTheAirTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  });

  List<TVSeries> get onTheAirTVSeries => _onTheAirTVSeries;
  List<TVSeries> get popularTVSeries => _popularTVSeries;
  List<TVSeries> get topRatedTVSeries => _topRatedTVSeries;

  RequestState get onTheAirTVSeriesState => _onTheAirTVSeriesState;
  RequestState get popularTVSeriesState => _popularTVSeriesState;
  RequestState get topRatedTVSeriesState => _topRatedTVSeriesState;

  get message => _message;

  Future<void> fetchOnTheAirTVSeries() async {
    _onTheAirTVSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getOnTheAirTVSeries.execute();
    result.fold((failure) {
      _onTheAirTVSeriesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _onTheAirTVSeriesState = RequestState.loaded;
      _onTheAirTVSeries = tvSeriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTVSeries() async {
    _popularTVSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold((failure) {
      _popularTVSeriesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _popularTVSeriesState = RequestState.loaded;
      _popularTVSeries = tvSeriesData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTVSeries() async {
    _topRatedTVSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold((failure) {
      _topRatedTVSeriesState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _topRatedTVSeriesState = RequestState.loaded;
      _topRatedTVSeries = tvSeriesData;
      notifyListeners();
    });
  }
}
