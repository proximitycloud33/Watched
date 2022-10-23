import 'dart:async';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  MovieDetailBloc(
    this._getMovieDetail,
    this._getMovieRecommendations,
  ) : super(const MovieDetailState()) {
    on<FetchMovieDetail>(_fetchMovieDetail);
    on<FetchRecommendation>(_fetchRecommendation);
  }

  Future<void> _fetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(movieState: RequestState.loading));
    final detailResult = await _getMovieDetail.execute(event.id);

    detailResult.fold(
      (failure) => emit(state.copyWith(
          movieState: RequestState.error, message: failure.message)),
      (data) =>
          emit(state.copyWith(movieState: RequestState.loaded, movie: data)),
    );
  }

  Future<void> _fetchRecommendation(
    FetchRecommendation event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(recommendationState: RequestState.loading));
    final recommendationResult =
        await _getMovieRecommendations.execute(event.id);

    recommendationResult.fold(
        (failure) => emit(state.copyWith(
            message: failure.message, recommendationState: RequestState.error)),
        (data) => emit(state.copyWith(
            recommendationState: RequestState.loaded,
            movieRecommendations: data)));
  }
}
