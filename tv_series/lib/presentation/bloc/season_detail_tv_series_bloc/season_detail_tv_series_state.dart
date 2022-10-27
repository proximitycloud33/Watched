part of 'season_detail_tv_series_bloc.dart';

class SeasonDetailTVSeriesState extends Equatable {
  final TVSeriesSeasonDetail tvSeriesSeasonDetail;
  final RequestState seasonDetailState;
  final String message;
  const SeasonDetailTVSeriesState({
    this.tvSeriesSeasonDetail = _tvSeriesSeasonDetailStartingState,
    this.seasonDetailState = RequestState.empty,
    this.message = '',
  });

  SeasonDetailTVSeriesState copyWith({
    TVSeriesSeasonDetail? tvSeriesSeasonDetail,
    RequestState? seasonDetailState,
    String? message,
  }) {
    return SeasonDetailTVSeriesState(
      tvSeriesSeasonDetail: tvSeriesSeasonDetail ?? this.tvSeriesSeasonDetail,
      seasonDetailState: seasonDetailState ?? this.seasonDetailState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [tvSeriesSeasonDetail, seasonDetailState, message];
}

const _tvSeriesSeasonDetailStartingState = TVSeriesSeasonDetail(
  airDate: "",
  episodes: [
    Episode(
      airDate: "",
      episodeNumber: 1,
      id: 1,
      name: "",
      overview: "",
      productionCode: "",
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: "/",
      voteAverage: 1,
      voteCount: 1,
    ),
  ],
  name: "",
  id: "",
  purpleId: 1,
  posterPath: "",
  overview: "",
  seasonNumber: 1,
);
