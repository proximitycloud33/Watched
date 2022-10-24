part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
  @override
  List<Object?> get props => [];
}

class MovieListNowPlayingFetched extends MovieListEvent {}

class MovieListPopularFetched extends MovieListEvent {}

class MovieListTopRatedFetched extends MovieListEvent {}
