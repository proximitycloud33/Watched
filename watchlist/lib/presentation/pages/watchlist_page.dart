import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/widget/watchlist_card_list.dart';
import 'package:watchlist/watchlist_presentation.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistCubit>().fetchWatchlist();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistCubit>().fetchWatchlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistCubit, WatchlistState>(
          builder: (context, state) {
            if (state.watchlistRequestState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.watchlistRequestState == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final watchlist = state.watchlist[index];
                  return WatchlistCard(watchlist);
                },
                itemCount: state.watchlist.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.failureMessage),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
