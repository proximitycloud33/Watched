part of 'watchlist_cubit.dart';

class WatchlistState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final String watchlistMessage;
  final bool isAddedToWatchList;
  final String failureMessage;

  const WatchlistState({
    required this.watchlistMessage,
    required this.isAddedToWatchList,
    required this.failureMessage,
  });

  factory WatchlistState.startingState() {
    return const WatchlistState(
      watchlistMessage: '',
      isAddedToWatchList: false,
      failureMessage: '',
    );
  }
  WatchlistState copyWith({
    String? watchlistMessage,
    bool? isAddedToWatchList,
    String? failureMessage,
  }) {
    return WatchlistState(
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchList: isAddedToWatchList ?? this.isAddedToWatchList,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object> get props => [
        watchlistMessage,
        isAddedToWatchList,
        failureMessage,
        watchlistAddSuccessMessage,
        watchlistRemoveSuccessMessage,
      ];
}
