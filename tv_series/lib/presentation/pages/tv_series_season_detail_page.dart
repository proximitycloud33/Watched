import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series_bloc/season_detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/season_detail_content.dart';

class TVSeriesSeasonDetailPage extends StatefulWidget {
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
    context.read<SeasonDetailTVSeriesBloc>().add(SeasonDetailTVSeriesFetched(
        id: widget.id, season: widget.seasonNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonDetailTVSeriesBloc, SeasonDetailTVSeriesState>(
        builder: (context, state) {
          if (state.seasonDetailState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.seasonDetailState == RequestState.loaded) {
            return SafeArea(
              child: SeasonDetailContent(state.tvSeriesSeasonDetail),
            );
          } else {
            return const Center(
                child: Text(
              'Fail to load Season',
            ));
          }
        },
      ),
    );
  }
}
