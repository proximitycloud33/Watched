import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series_bloc/top_rated_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class TopRatedTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';
  const TopRatedTVSeriesPage({super.key});

  @override
  State<TopRatedTVSeriesPage> createState() => _TopRatedTVSeriesPageState();
}

class _TopRatedTVSeriesPageState extends State<TopRatedTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTVSeriesBloc>().add(const TopRatedTVSeriesFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
          builder: (context, state) {
            if (state.topRatedTVSeriesRequestState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.topRatedTVSeriesRequestState ==
                RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.topRatedTVSeries[index];
                  return TVSeriesCardList(tvSeries);
                },
                itemCount: state.topRatedTVSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            }
          },
        ),
      ),
    );
  }
}
