import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/watchlist_domain.dart';
part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlist _getWatchlist;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistCubit(
    this._getWatchlist,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(const WatchlistState());

  Future<void> fetchWatchlist() async {
    emit(state.copyWith(watchlistRequestState: RequestState.loading));
    final fetchResult = await _getWatchlist.execute();
    fetchResult.fold(
        (failure) => emit(state.copyWith(failureMessage: failure.message)),
        (data) => emit(state.copyWith(
            watchlist: data, watchlistRequestState: RequestState.loaded)));
  }

  Future<void> addWatchlist(Watchlist watchlist) async {
    final addResult = await _saveWatchlist.execute(watchlist);
    addResult.fold(
        (failure) => emit(state.copyWith(failureMessage: failure.message)),
        (data) => emit(state.copyWith(
              watchlistMessage: WatchlistState.watchlistAddSuccessMessage,
            )));
    loadWatchlistStatus(watchlist.id);
  }

  Future<void> removeFromWatchlist(Watchlist watchlist) async {
    final removeResult = await _removeWatchlist.execute(watchlist);
    removeResult.fold(
        (failure) => emit(state.copyWith(failureMessage: failure.message)),
        (data) => emit(state.copyWith(
            watchlistMessage: WatchlistState.watchlistRemoveSuccessMessage)));

    loadWatchlistStatus(watchlist.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await _getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedToWatchList: result));
  }
}
