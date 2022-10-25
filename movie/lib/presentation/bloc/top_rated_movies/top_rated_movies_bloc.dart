import 'dart:async';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesBloc(this.getTopRatedMovies)
      : super(const TopRatedMoviesState()) {
    on<TopRatedMoviesFetched>(
      _onTopRatedMoviesFetched,
    );
  }

  Future<void> _onTopRatedMoviesFetched(
    TopRatedMoviesFetched event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(state.copyWith(topRatedMoviesRequestState: RequestState.loading));
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        topRatedMoviesRequestState: RequestState.empty,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        topRatedMoviesRequestState: RequestState.loaded,
        topRatedMovies: data,
      )),
    );
  }
}
