part of 'watchlist_cubit.dart';

class WatchlistState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final List<Watchlist> watchlist;
  final RequestState watchlistRequestState;
  final String watchlistMessage;
  final bool isAddedToWatchList;
  final String failureMessage;

  const WatchlistState({
    this.watchlistRequestState = RequestState.empty,
    this.watchlist = const <Watchlist>[],
    this.watchlistMessage = '',
    this.isAddedToWatchList = false,
    this.failureMessage = '',
  });

  WatchlistState copyWith({
    List<Watchlist>? watchlist,
    RequestState? watchlistRequestState,
    String? watchlistMessage,
    bool? isAddedToWatchList,
    String? failureMessage,
  }) {
    return WatchlistState(
      watchlist: watchlist ?? this.watchlist,
      watchlistRequestState:
          watchlistRequestState ?? this.watchlistRequestState,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchList: isAddedToWatchList ?? this.isAddedToWatchList,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object> get props => [
        watchlist,
        watchlistRequestState,
        watchlistMessage,
        isAddedToWatchList,
        failureMessage,
      ];
}
