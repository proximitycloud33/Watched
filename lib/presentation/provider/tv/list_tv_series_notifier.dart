import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:flutter/foundation.dart';

class ListTVSeriesNotifier extends ChangeNotifier {
  var _onTheAirTVSeries = <TVSeries>[];
  var _popularTVSeries = <TVSeries>[];
  var _topRatedTVSeries = <TVSeries>[];

  String _message = '';

  RequestState _onTheAirTVSeriesState = RequestState.Empty;
  RequestState _popularTVSeriesState = RequestState.Empty;
  RequestState _topRatedTVSeriesState = RequestState.Empty;

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
    _onTheAirTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTVSeries.execute();
    result.fold((failure) {
      _onTheAirTVSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _onTheAirTVSeriesState = RequestState.Loaded;
      _onTheAirTVSeries = tvSeriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTVSeries() async {
    _popularTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold((failure) {
      _popularTVSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _popularTVSeriesState = RequestState.Loaded;
      _popularTVSeries = tvSeriesData;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTVSeries() async {
    _topRatedTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold((failure) {
      _topRatedTVSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _topRatedTVSeriesState = RequestState.Loaded;
      _topRatedTVSeries = tvSeriesData;
      notifyListeners();
    });
  }
}
