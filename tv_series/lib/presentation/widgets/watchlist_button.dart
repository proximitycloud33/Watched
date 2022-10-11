import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/presentation/provider/detail_tv_series_notifier.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

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
          await Provider.of<DetailTVSeriesNotifier>(context, listen: false)
              .addWatchlist(
            Watchlist(
              id: tvSeriesDetail.id,
              type: 'tv',
              overview: tvSeriesDetail.overview,
              posterPath: tvSeriesDetail.posterPath,
              title: tvSeriesDetail.name,
            ),
          );
        } else {
          await Provider.of<DetailTVSeriesNotifier>(context, listen: false)
              .removeFromWatchlist(
            Watchlist(
              id: tvSeriesDetail.id,
              type: 'tv',
              overview: tvSeriesDetail.overview,
              posterPath: tvSeriesDetail.posterPath,
              title: tvSeriesDetail.name,
            ),
          );
        }
        final message =
            // ignore: use_build_context_synchronously
            Provider.of<DetailTVSeriesNotifier>(context, listen: false)
                .watchlistMessage;

        if (message == DetailTVSeriesNotifier.watchlistAddSuccessMessage ||
            message == DetailTVSeriesNotifier.watchlistRemoveSuccessMessage) {
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
