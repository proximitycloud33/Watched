import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series_bloc/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class PopularTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';
  const PopularTVSeriesPage({super.key});

  @override
  State<PopularTVSeriesPage> createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTVSeriesBloc>().add(const PopularTVSeriesFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
          builder: (context, state) {
            if (state.popularTVSeriesRequestState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.popularTVSeriesRequestState ==
                RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.popularTVSeries[index];
                  return TVSeriesCardList(tvSeries);
                },
                itemCount: state.popularTVSeries.length,
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
