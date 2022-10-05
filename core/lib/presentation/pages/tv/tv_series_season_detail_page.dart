import '../../../common/state_enum.dart';
import 'package:core/core/lib/presentation/provider/tv/season_detail_tv_series_notifier.dart';
import 'package:core/core/lib/presentation/widgets/season_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TVSeriesSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/season-detail-tvseries';
  final int id;
  final int seasonNumber;
  const TVSeriesSeasonDetailPage({
    super.key,
    required this.id,
    required this.seasonNumber,
  });

  @override
  State<TVSeriesSeasonDetailPage> createState() =>
      _TVSeriesSeasonDetailPageState();
}

class _TVSeriesSeasonDetailPageState extends State<TVSeriesSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SeasonDetailTVSeriesNotifier>(context, listen: false)
          .fetchTVSeriesSeasonDetail(widget.id, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SeasonDetailTVSeriesNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == RequestState.Loaded) {
            return SafeArea(
              child: SeasonDetailContent(provider.tvSeriesSeasonDetail),
            );
          } else {
            return const Center(
                child: Text(
              'Failure to load Season',
            ));
          }
        },
      ),
    );
  }
}
