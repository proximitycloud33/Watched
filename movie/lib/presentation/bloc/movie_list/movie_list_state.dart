part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final RequestState nowPlayingMoviesState;
  final RequestState popularMoviesState;
  final RequestState topRatedMoviesState;
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final String message;

  const MovieListState({
    this.nowPlayingMoviesState = RequestState.empty,
    this.popularMoviesState = RequestState.empty,
    this.topRatedMoviesState = RequestState.empty,
    this.nowPlayingMovies = const <Movie>[],
    this.popularMovies = const <Movie>[],
    this.topRatedMovies = const <Movie>[],
    this.message = '',
  });

  MovieListState copyWith({
    RequestState? nowPlayingMoviesState,
    RequestState? popularMoviesState,
    RequestState? topRatedMoviesState,
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    String? message,
  }) {
    return MovieListState(
      nowPlayingMoviesState:
          nowPlayingMoviesState ?? this.nowPlayingMoviesState,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props {
    return [
      nowPlayingMoviesState,
      popularMoviesState,
      topRatedMoviesState,
      nowPlayingMovies,
      popularMovies,
      topRatedMovies,
      message,
    ];
  }
}
