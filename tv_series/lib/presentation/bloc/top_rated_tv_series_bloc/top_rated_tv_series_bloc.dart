import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTVSeriesBloc
    extends Bloc<TopRatedTVSeriesEvent, TopRatedTVSeriesState> {
  final GetTopRatedTVSeries getTopRatedTVSeries;
  TopRatedTVSeriesBloc(this.getTopRatedTVSeries)
      : super(const TopRatedTVSeriesState()) {
    on<TopRatedTVSeriesFetched>(_onTopRatedTVSeriesFetched);
  }

  Future<void> _onTopRatedTVSeriesFetched(
    TopRatedTVSeriesFetched event,
    Emitter<TopRatedTVSeriesState> emit,
  ) async {
    emit(state.copyWith(topRatedTVSeriesRequestState: RequestState.loading));

    final result = await getTopRatedTVSeries.execute();
    result.fold(
      (failure) => emit(state.copyWith(
        topRatedTVSeriesRequestState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        topRatedTVSeriesRequestState: RequestState.loaded,
        topRatedTVSeries: data,
      )),
    );
  }
}
