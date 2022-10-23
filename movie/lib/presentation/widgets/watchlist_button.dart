import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/watchlist_presentation.dart';

// Just make cubit for this
class WatchlistButton extends StatelessWidget {
  const WatchlistButton({
    Key? key,
    required this.isAddedWatchlist,
    required this.movie,
  }) : super(key: key);

  final bool isAddedWatchlist;
  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!isAddedWatchlist) {
          context.read<WatchlistCubit>().addWatchlist(
                Watchlist(
                  id: movie.id,
                  type: 'movie',
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                  title: movie.title,
                ),
              );
        } else {
          context.read<WatchlistCubit>().removeFromWatchlist(
                Watchlist(
                  id: movie.id,
                  type: 'movie',
                  overview: movie.overview,
                  posterPath: movie.posterPath,
                  title: movie.title,
                ),
              );
        }
        final message = context.read<WatchlistCubit>().state.watchlistMessage;

        if (message == WatchlistState.watchlistAddSuccessMessage ||
            message == WatchlistState.watchlistRemoveSuccessMessage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(message),
                );
              });
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAddedWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
          const Text('Watchlist'),
        ],
      ),
    );
  }
}
