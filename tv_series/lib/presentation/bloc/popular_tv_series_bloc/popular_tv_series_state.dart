part of 'popular_tv_series_bloc.dart';

class PopularTVSeriesState extends Equatable {
  final RequestState popularTVSeriesRequestState;
  final List<TVSeries> popularTVSeries;
  final String message;

  const PopularTVSeriesState({
    this.popularTVSeriesRequestState = RequestState.empty,
    this.popularTVSeries = const <TVSeries>[],
    this.message = '',
  });

  PopularTVSeriesState copyWith({
    RequestState? popularTVSeriesRequestState,
    List<TVSeries>? popularTVSeries,
    String? message,
  }) {
    return PopularTVSeriesState(
      popularTVSeriesRequestState:
          popularTVSeriesRequestState ?? this.popularTVSeriesRequestState,
      popularTVSeries: popularTVSeries ?? this.popularTVSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        popularTVSeriesRequestState,
        popularTVSeries,
        message,
      ];
}
