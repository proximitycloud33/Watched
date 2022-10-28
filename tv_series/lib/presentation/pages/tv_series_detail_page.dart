import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/widgets/detail_content_tv_series.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

import '../bloc/detail_tv_series_bloc/detail_tv_series_bloc.dart';

class TVSeriesDetailPage extends StatefulWidget {
  final int id;
  const TVSeriesDetailPage({super.key, required this.id});

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistCubit>().loadWatchlistStatus(widget.id);
    context
        .read<DetailTVSeriesBloc>()
        .add(DetailTVSeriesFetched(id: widget.id));
    context
        .read<DetailTVSeriesBloc>()
        .add(DetailTVSeriesRecommendationFetched(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTVSeriesBloc, DetailTVSeriesState>(
        builder: (context, state) {
          if (state.tvSeriesDetailState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.tvSeriesDetailState == RequestState.loaded) {
            return SafeArea(
              child: DetailContentTVSeries(state.tvSeriesDetail),
            );
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}
