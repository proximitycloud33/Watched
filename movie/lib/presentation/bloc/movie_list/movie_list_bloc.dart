import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc() : super(MovieListInitial()) {
    on<MovieListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
