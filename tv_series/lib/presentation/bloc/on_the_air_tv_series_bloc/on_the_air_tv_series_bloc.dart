import 'dart:async';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
part 'on_the_air_tv_series_event.dart';
part 'on_the_air_tv_series_state.dart';

class OnTheAirTVSeriesBloc
    extends Bloc<OnTheAirTVSeriesEvent, OnTheAirTVSeriesState> {
  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  OnTheAirTVSeriesBloc(this.getOnTheAirTVSeries)
      : super(const OnTheAirTVSeriesState()) {
    on<OnTheAirTVSeriesFetched>(_onTheAirTVSeriesFetched);
  }

  Future<void> _onTheAirTVSeriesFetched(
    OnTheAirTVSeriesFetched event,
    Emitter<OnTheAirTVSeriesState> emit,
  ) async {
    emit(state.copyWith(onTheAirTVSeriesRequestState: RequestState.loading));

    final result = await getOnTheAirTVSeries.execute();

    result.fold(
      (failure) => emit(state.copyWith(
          onTheAirTVSeriesRequestState: RequestState.error,
          message: failure.message)),
      (data) => emit(state.copyWith(
        onTheAirTVSeriesRequestState: RequestState.loaded,
        onTheAirTVSeries: data,
      )),
    );
  }
}
