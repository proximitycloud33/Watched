part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final RequestState movieState;
  final RequestState recommendationState;
  final MovieDetail movie;
  final List<Movie> movieRecommendations;
  final String message;

  const MovieDetailState({
    this.movieState = RequestState.empty,
    this.recommendationState = RequestState.empty,
    this.movie = _movieDetailStartingState,
    this.movieRecommendations = const <Movie>[],
    this.message = '',
  });

  @override
  List<Object> get props {
    return [
      movie,
      movieState,
      movieRecommendations,
      recommendationState,
      message,
    ];
  }

  MovieDetailState copyWith({
    RequestState? movieState,
    RequestState? recommendationState,
    MovieDetail? movie,
    List<Movie>? movieRecommendations,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchList,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      message: message ?? this.message,
      movieState: movieState ?? this.movieState,
      recommendationState: recommendationState ?? this.recommendationState,
    );
  }
}

const _movieDetailStartingState = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);
