import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/presentation/provider/tv/detail_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              overview: tvSeriesDetail.overview,
              posterPath: tvSeriesDetail.posterPath,
              title: tvSeriesDetail.name,
            ),
          );
        }
        final message =
            Provider.of<DetailTVSeriesNotifier>(context, listen: false)
                .watchlistMessage;

        if (message == DetailTVSeriesNotifier.watchlistAddSuccessMessage ||
            message == DetailTVSeriesNotifier.watchlistRemoveSuccessMessage) {
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
          isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
          Text('Watchlist'),
        ],
      ),
    );
  }
}
