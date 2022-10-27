import 'dart:async';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series_domain.dart';
part 'list_tv_series_event.dart';
part 'list_tv_series_state.dart';

class ListTVSeriesBloc extends Bloc<ListTVSeriesEvent, ListTVSeriesState> {
  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;
  ListTVSeriesBloc(
    this.getOnTheAirTVSeries,
    this.getPopularTVSeries,
    this.getTopRatedTVSeries,
  ) : super(const ListTVSeriesState()) {
    on<ListTVSeriesOnTheAirFetched>(_onListTVSeriesOnTheAirFetched);
    on<ListTVSeriesPopularFetched>(_onListTVSeriesPopularFetched);
    on<ListTVSeriesTopRatedFetched>(_onListTVSeriesTopRatedFetched);
  }

  Future<void> _onListTVSeriesOnTheAirFetched(
    ListTVSeriesOnTheAirFetched event,
    Emitter<ListTVSeriesState> emit,
  ) async {
    emit(state.copyWith(onTheAirTVSeriesState: RequestState.loading));

    final result = await getOnTheAirTVSeries.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        onTheAirTVSeriesState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        onTheAirTVSeriesState: RequestState.loaded,
        onTheAirTVSeries: data,
      )),
    );
  }

  Future<void> _onListTVSeriesPopularFetched(
    ListTVSeriesPopularFetched event,
    Emitter<ListTVSeriesState> emit,
  ) async {
    emit(state.copyWith(popularTVSeriesState: RequestState.loading));

    final result = await getPopularTVSeries.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        popularTVSeriesState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        popularTVSeriesState: RequestState.loaded,
        popularTVSeries: data,
      )),
    );
  }

  Future<void> _onListTVSeriesTopRatedFetched(
    ListTVSeriesTopRatedFetched event,
    Emitter<ListTVSeriesState> emit,
  ) async {
    emit(state.copyWith(topRatedTVSeriesState: RequestState.loading));

    final result = await getTopRatedTVSeries.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        topRatedTVSeriesState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        topRatedTVSeriesState: RequestState.loaded,
        topRatedTVSeries: data,
      )),
    );
  }
}
