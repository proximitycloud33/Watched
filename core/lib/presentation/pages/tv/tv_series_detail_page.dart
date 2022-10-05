import '../../../common/state_enum.dart';
import 'package:core/core/lib/presentation/widgets/detail_content_tv_series.dart';
import 'package:core/core/lib/presentation/provider/tv/detail_tv_series_notifier.dart';
import 'package:core/core/lib/presentation/provider/tv/recommendation_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tvseries';
  final int id;
  const TVSeriesDetailPage({super.key, required this.id});

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider =
          Provider.of<DetailTVSeriesNotifier>(context, listen: false);
      provider.fetchTVSeriesDetail(widget.id);
      provider.loadWatchlistStatus(widget.id);
      Provider.of<RecommendationTVSeriesNotifier>(context, listen: false)
          .fetchRecommendationTVSeries(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<DetailTVSeriesNotifier, RecommendationTVSeriesNotifier>(
        builder: (context, provider1, provider2, child) {
          if (provider1.tvSeriesState == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider1.tvSeriesState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContentTVSeries(
                provider1.tvSeriesDetail,
                provider2.tvSeriesRecommendation,
                provider1.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider1.message);
          }
        },
      ),
    );
  }
}
