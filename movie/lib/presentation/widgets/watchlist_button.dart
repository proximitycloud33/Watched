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
      onPressed: () async {
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
        await Future.delayed(
          const Duration(milliseconds: 150),
          () {
            final message =
                context.read<WatchlistCubit>().state.watchlistMessage;
            final failureMessage =
                context.read<WatchlistCubit>().state.failureMessage;

            if (message == WatchlistState.watchlistAddSuccessMessage ||
                message == WatchlistState.watchlistRemoveSuccessMessage) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(failureMessage),
                    );
                  });
            }
          },
        );
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
