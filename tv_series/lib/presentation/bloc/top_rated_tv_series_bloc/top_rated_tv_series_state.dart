part of 'top_rated_tv_series_bloc.dart';

class TopRatedTVSeriesState extends Equatable {
  final RequestState topRatedTVSeriesRequestState;
  final List<TVSeries> topRatedTVSeries;
  final String message;

  const TopRatedTVSeriesState({
    this.topRatedTVSeriesRequestState = RequestState.empty,
    this.topRatedTVSeries = const <TVSeries>[],
    this.message = '',
  });

  TopRatedTVSeriesState copyWith({
    RequestState? topRatedTVSeriesRequestState,
    List<TVSeries>? topRatedTVSeries,
    String? message,
  }) {
    return TopRatedTVSeriesState(
      topRatedTVSeriesRequestState:
          topRatedTVSeriesRequestState ?? this.topRatedTVSeriesRequestState,
      topRatedTVSeries: topRatedTVSeries ?? this.topRatedTVSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        topRatedTVSeriesRequestState,
        topRatedTVSeries,
        message,
      ];
}
