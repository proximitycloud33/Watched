import 'dart:async';

import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/movie_domain.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  MovieListBloc(
    this.getNowPlayingMovies,
    this.getPopularMovies,
    this.getTopRatedMovies,
  ) : super(const MovieListState()) {
    on<MovieListNowPlayingFetched>(_onMovieListNowPlaytingFetched);
    on<MovieListPopularFetched>(_onMovieListPopularFetched);
    on<MovieListTopRatedFetched>(_onMovieListTopRatedFetched);
  }

  Future<void> _onMovieListNowPlaytingFetched(
    MovieListNowPlayingFetched event,
    emit,
  ) async {
    emit(state.copyWith(nowPlayingMoviesState: RequestState.loading));
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        message: failure.message,
        nowPlayingMoviesState: RequestState.empty,
      )),
      (data) => emit(state.copyWith(
        nowPlayingMoviesState: RequestState.loaded,
        nowPlayingMovies: data,
      )),
    );
  }

  Future<void> _onMovieListPopularFetched(
    MovieListPopularFetched event,
    emit,
  ) async {
    emit(state.copyWith(popularMoviesState: RequestState.loading));
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        message: failure.message,
        popularMoviesState: RequestState.empty,
      )),
      (data) => emit(state.copyWith(
        popularMoviesState: RequestState.loaded,
        popularMovies: data,
      )),
    );
  }

  Future<void> _onMovieListTopRatedFetched(
    MovieListTopRatedFetched event,
    emit,
  ) async {
    emit(state.copyWith(topRatedMoviesState: RequestState.loading));
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        message: failure.message,
        topRatedMoviesState: RequestState.empty,
      )),
      (data) => emit(state.copyWith(
        topRatedMoviesState: RequestState.loaded,
        topRatedMovies: data,
      )),
    );
  }
}
