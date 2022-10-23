part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetail extends MovieDetailEvent {
  final int id;
  const FetchMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class FetchRecommendation extends MovieDetailEvent {
  final int id;
  const FetchRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}
