import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

class WatchlistButton extends StatelessWidget {
  const WatchlistButton({
    Key? key,
    required this.isAddedWatchlist,
    required this.tvSeriesDetail,
  }) : super(key: key);

  final bool isAddedWatchlist;
  final TVSeriesDetail tvSeriesDetail;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!isAddedWatchlist) {
          await context.read<WatchlistCubit>().addWatchlist(
                Watchlist(
                  id: tvSeriesDetail.id,
                  type: 'tv',
                  overview: tvSeriesDetail.overview,
                  posterPath: tvSeriesDetail.posterPath,
                  title: tvSeriesDetail.name,
                ),
              );
        } else {
          await context.read<WatchlistCubit>().removeFromWatchlist(
                Watchlist(
                  id: tvSeriesDetail.id,
                  type: 'tv',
                  overview: tvSeriesDetail.overview,
                  posterPath: tvSeriesDetail.posterPath,
                  title: tvSeriesDetail.name,
                ),
              );
        }
        await Future.delayed(
          const Duration(milliseconds: 150),
          () {
            final message =
                context.read<WatchlistCubit>().state.watchlistMessage;

            if (message == WatchlistState.watchlistAddSuccessMessage ||
                message == WatchlistState.watchlistRemoveSuccessMessage) {
              // ignore: use_build_context_synchronously
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
