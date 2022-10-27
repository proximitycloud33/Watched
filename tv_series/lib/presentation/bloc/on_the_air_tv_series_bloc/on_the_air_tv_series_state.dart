part of 'on_the_air_tv_series_bloc.dart';

class OnTheAirTVSeriesState extends Equatable {
  final RequestState onTheAirTVSeriesRequestState;
  final List<TVSeries> onTheAirTVSeries;
  final String message;

  const OnTheAirTVSeriesState({
    this.onTheAirTVSeriesRequestState = RequestState.empty,
    this.onTheAirTVSeries = const <TVSeries>[],
    this.message = '',
  });

  OnTheAirTVSeriesState copyWith({
    RequestState? onTheAirTVSeriesRequestState,
    List<TVSeries>? onTheAirTVSeries,
    String? message,
  }) {
    return OnTheAirTVSeriesState(
      onTheAirTVSeriesRequestState:
          onTheAirTVSeriesRequestState ?? this.onTheAirTVSeriesRequestState,
      onTheAirTVSeries: onTheAirTVSeries ?? this.onTheAirTVSeries,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        onTheAirTVSeriesRequestState,
        onTheAirTVSeries,
        message,
      ];
}
