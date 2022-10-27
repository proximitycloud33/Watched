import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTVSeriesBloc
    extends Bloc<PopularTVSeriesEvent, PopularTVSeriesState> {
  final GetPopularTVSeries getPopularTVSeries;
  PopularTVSeriesBloc(this.getPopularTVSeries)
      : super(const PopularTVSeriesState()) {
    on<PopularTVSeriesFetched>(_onPopularTVSeriesFetched);
  }

  Future<void> _onPopularTVSeriesFetched(
    PopularTVSeriesFetched event,
    Emitter<PopularTVSeriesState> emit,
  ) async {
    emit(state.copyWith(popularTVSeriesRequestState: RequestState.loading));

    final result = await getPopularTVSeries.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        popularTVSeriesRequestState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        popularTVSeriesRequestState: RequestState.loaded,
        popularTVSeries: data,
      )),
    );
  }
}
