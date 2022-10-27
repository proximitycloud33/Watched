import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_season_detail_tv_series.dart';

part 'season_detail_tv_series_event.dart';
part 'season_detail_tv_series_state.dart';

class SeasonDetailTVSeriesBloc
    extends Bloc<SeasonDetailTVSeriesEvent, SeasonDetailTVSeriesState> {
  final GetSeasonDetailTVSeries getSeasonDetailTVSeries;
  SeasonDetailTVSeriesBloc(this.getSeasonDetailTVSeries)
      : super(const SeasonDetailTVSeriesState()) {
    on<SeasonDetailTVSeriesFetched>(_onSeasonDetailTVSeriesFetched);
  }

  Future<void> _onSeasonDetailTVSeriesFetched(SeasonDetailTVSeriesFetched event,
      Emitter<SeasonDetailTVSeriesState> emit) async {
    emit(state.copyWith(seasonDetailState: RequestState.loading));

    final result =
        await getSeasonDetailTVSeries.execute(event.id, event.season);

    result.fold(
      (failure) => emit(state.copyWith(
        seasonDetailState: RequestState.error,
        message: failure.message,
      )),
      (data) => emit(state.copyWith(
        seasonDetailState: RequestState.loaded,
        tvSeriesSeasonDetail: data,
      )),
    );
  }
}
