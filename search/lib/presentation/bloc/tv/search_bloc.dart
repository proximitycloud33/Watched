import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTVSeries _searchTVSeries;
  SearchTVSeriesBloc(this._searchTVSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final result = await _searchTVSeries.execute(query);

      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (data) {
        emit(SearchHasData(data));
      });
    }, transformer: _debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> _debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
