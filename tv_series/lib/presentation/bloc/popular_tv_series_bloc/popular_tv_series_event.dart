part of 'popular_tv_series_bloc.dart';

abstract class PopularTVSeriesEvent extends Equatable {
  const PopularTVSeriesEvent();

  @override
  List<Object?> get props => [];
}

class PopularTVSeriesFetched extends PopularTVSeriesEvent {
  const PopularTVSeriesFetched();

  @override
  List<Object?> get props => [];
}
