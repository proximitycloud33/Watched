part of 'detail_tv_series_bloc.dart';

class DetailTVSeriesEvent extends Equatable {
  const DetailTVSeriesEvent();

  @override
  List<Object?> get props => [];
}

class DetailTVSeriesFetched extends DetailTVSeriesEvent {
  final int id;
  const DetailTVSeriesFetched({required this.id});

  @override
  List<Object?> get props => [id];
}

class DetailTVSeriesRecommendationFetched extends DetailTVSeriesEvent {
  final int id;
  const DetailTVSeriesRecommendationFetched({required this.id});

  @override
  List<Object?> get props => [id];
}
