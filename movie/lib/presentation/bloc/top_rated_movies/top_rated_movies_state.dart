part of 'top_rated_movies_bloc.dart';

class TopRatedMoviesState extends Equatable {
  final List<Movie> topRatedMovies;
  final RequestState topRatedMoviesRequestState;
  final String message;

  const TopRatedMoviesState({
    this.topRatedMovies = const <Movie>[],
    this.topRatedMoviesRequestState = RequestState.empty,
    this.message = '',
  });

  TopRatedMoviesState copyWith({
    List<Movie>? topRatedMovies,
    RequestState? topRatedMoviesRequestState,
    String? message,
  }) {
    return TopRatedMoviesState(
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedMoviesRequestState:
          topRatedMoviesRequestState ?? this.topRatedMoviesRequestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        topRatedMovies,
        topRatedMoviesRequestState,
        message,
      ];
}
