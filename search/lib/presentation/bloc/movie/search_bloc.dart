import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:rxdart/transformers.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchMoviesBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          if (data.isNotEmpty) {
            emit(SearchHasData(data));
          } else {
            emit(SearchNotFound(data));
          }
        },
      );
    }, transformer: _debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> _debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
