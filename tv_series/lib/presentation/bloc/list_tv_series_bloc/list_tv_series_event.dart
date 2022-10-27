part of 'list_tv_series_bloc.dart';

abstract class ListTVSeriesEvent extends Equatable {
  const ListTVSeriesEvent();

  @override
  List<Object?> get props => [];
}

class ListTVSeriesOnTheAirFetched extends ListTVSeriesEvent {}

class ListTVSeriesPopularFetched extends ListTVSeriesEvent {}

class ListTVSeriesTopRatedFetched extends ListTVSeriesEvent {}
