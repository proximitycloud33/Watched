import 'dart:async';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc(this.getPopularMovies) : super(const PopularMoviesState()) {
    on<PopularMoviesFetched>(_onPopularMoviesFetched);
  }

  Future<void> _onPopularMoviesFetched(
    PopularMoviesFetched event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(state.copyWith(popularMoviesRequestState: RequestState.loading));
    final result = await getPopularMovies.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        popularMoviesRequestState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        popularMoviesRequestState: RequestState.loaded,
        popularMovies: data,
      )),
    );
  }
}
