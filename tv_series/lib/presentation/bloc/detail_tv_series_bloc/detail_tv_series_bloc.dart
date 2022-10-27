import 'dart:async';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/season.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/tv_series_domain.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTVSeriesBloc
    extends Bloc<DetailTVSeriesEvent, DetailTVSeriesState> {
  final GetDetailTVSeries getDetailTVSeries;
  final GetRecommendationTVSeries getRecommendationTVSeries;
  DetailTVSeriesBloc(
    this.getDetailTVSeries,
    this.getRecommendationTVSeries,
  ) : super(const DetailTVSeriesState()) {
    on<DetailTVSeriesFetched>(_onDetailTVSeriesFetched);
    on<DetailTVSeriesRecommendationFetched>(
        _onDetailTVSeriesRecommendationFetched);
  }

  Future<void> _onDetailTVSeriesFetched(
    DetailTVSeriesFetched event,
    Emitter<DetailTVSeriesState> emit,
  ) async {
    emit(state.copyWith(tvSeriesDetailState: RequestState.loading));

    final result = await getDetailTVSeries.execute(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        tvSeriesDetailState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        tvSeriesDetailState: RequestState.loaded,
        tvSeriesDetail: data,
      )),
    );
  }

  Future<void> _onDetailTVSeriesRecommendationFetched(
    DetailTVSeriesRecommendationFetched event,
    Emitter<DetailTVSeriesState> emit,
  ) async {
    emit(state.copyWith(recommendationState: RequestState.loading));

    final result = await getRecommendationTVSeries.execute(event.id);

    result.fold(
      (failure) => emit(state.copyWith(
        recommendationState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        recommendationState: RequestState.loaded,
        tvSeriesRecommendations: data,
      )),
    );
  }
}
