part of 'popular_movies_bloc.dart';

class PopularMoviesState extends Equatable {
  final List<Movie> popularMovies;
  final RequestState popularMoviesRequestState;
  final String message;

  const PopularMoviesState({
    this.popularMovies = const <Movie>[],
    this.popularMoviesRequestState = RequestState.empty,
    this.message = '',
  });

  PopularMoviesState copyWith({
    List<Movie>? popularMovies,
    RequestState? popularMoviesRequestState,
    String? message,
  }) {
    return PopularMoviesState(
      popularMovies: popularMovies ?? this.popularMovies,
      popularMoviesRequestState:
          popularMoviesRequestState ?? this.popularMoviesRequestState,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        popularMovies,
        popularMoviesRequestState,
        message,
      ];
}
