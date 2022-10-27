part of 'season_detail_tv_series_bloc.dart';

class SeasonDetailTVSeriesEvent extends Equatable {
  const SeasonDetailTVSeriesEvent();

  @override
  List<Object?> get props => [];
}

class SeasonDetailTVSeriesFetched extends SeasonDetailTVSeriesEvent {
  final int id;
  final int season;

  const SeasonDetailTVSeriesFetched({
    required this.id,
    required this.season,
  });

  @override
  List<Object?> get props => [id, season];
}
