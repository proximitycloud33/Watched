import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_series.dart';
import 'package:flutter/foundation.dart';

class SearchTVSeriesNotifier extends ChangeNotifier {
  final SearchTVSeries searchTVSeries;

  RequestState _state = RequestState.Empty;
  List<TVSeries> _searchResult = [];
  String _message = '';

  SearchTVSeriesNotifier(this.searchTVSeries);

  String get message => _message;
  List<TVSeries> get searchResult => _searchResult;
  RequestState get state => _state;

  Future<void> fetchSearchTVSeries(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
