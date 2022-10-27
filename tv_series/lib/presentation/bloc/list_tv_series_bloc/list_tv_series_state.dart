part of 'list_tv_series_bloc.dart';

class ListTVSeriesState extends Equatable {
  final RequestState onTheAirTVSeriesState;
  final RequestState popularTVSeriesState;
  final RequestState topRatedTVSeriesState;
  final List<TVSeries> onTheAirTVSeries;
  final List<TVSeries> popularTVSeries;
  final List<TVSeries> topRatedTVSeries;
  final String message;

  const ListTVSeriesState({
    this.onTheAirTVSeriesState = RequestState.empty,
    this.popularTVSeriesState = RequestState.empty,
    this.topRatedTVSeriesState = RequestState.empty,
    this.onTheAirTVSeries = const <TVSeries>[],
    this.popularTVSeries = const <TVSeries>[],
    this.topRatedTVSeries = const <TVSeries>[],
    this.message = '',
  });

  ListTVSeriesState copyWith({
    RequestState? onTheAirTVSeriesState,
    RequestState? popularTVSeriesState,
    RequestState? topRatedTVSeriesState,
    List<TVSeries>? onTheAirTVSeries,
    List<TVSeries>? popularTVSeries,
    List<TVSeries>? topRatedTVSeries,
    String? message,
  }) {
    return ListTVSeriesState(
      onTheAirTVSeriesState:
          onTheAirTVSeriesState ?? this.onTheAirTVSeriesState,
      popularTVSeriesState: popularTVSeriesState ?? this.popularTVSeriesState,
      topRatedTVSeriesState:
          topRatedTVSeriesState ?? this.topRatedTVSeriesState,
      onTheAirTVSeries: onTheAirTVSeries ?? this.onTheAirTVSeries,
      popularTVSeries: popularTVSeries ?? this.popularTVSeries,
      topRatedTVSeries: topRatedTVSeries ?? this.topRatedTVSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      onTheAirTVSeriesState,
      popularTVSeriesState,
      topRatedTVSeriesState,
      onTheAirTVSeries,
      popularTVSeries,
      topRatedTVSeries,
      message,
    ];
  }
}
