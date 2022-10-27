part of 'detail_tv_series_bloc.dart';

class DetailTVSeriesState extends Equatable {
  final RequestState tvSeriesDetailState;
  final RequestState recommendationState;
  final TVSeriesDetail tvSeriesDetail;
  final List<TVSeries> tvSeriesRecommendations;
  final String message;

  const DetailTVSeriesState({
    this.tvSeriesDetailState = RequestState.empty,
    this.recommendationState = RequestState.empty,
    this.tvSeriesDetail = _tvSeriesDetailStartingState,
    this.tvSeriesRecommendations = const <TVSeries>[],
    this.message = '',
  });

  DetailTVSeriesState copyWith({
    RequestState? tvSeriesDetailState,
    RequestState? recommendationState,
    TVSeriesDetail? tvSeriesDetail,
    List<TVSeries>? tvSeriesRecommendations,
    String? message,
  }) {
    return DetailTVSeriesState(
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      recommendationState: recommendationState ?? this.recommendationState,
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvSeriesRecommendations:
          tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      tvSeriesDetailState,
      recommendationState,
      tvSeriesDetail,
      tvSeriesRecommendations,
      message,
    ];
  }
}

const _tvSeriesDetailStartingState = TVSeriesDetail(
  adult: false,
  firstAirDate: '2022-08-21',
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'Dragon',
  originalName: 'House of Dragon',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  seasons: [
    Season(
      airDate: '2022-08-21',
      episodeCount: 10,
      id: 1,
      name: 'Dragon',
      overview: '',
      posterPath: '',
      seasonNumber: 1,
    )
  ],
  voteAverage: 1,
  voteCount: 1,
);
