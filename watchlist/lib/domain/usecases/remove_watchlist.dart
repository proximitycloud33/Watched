import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class RemoveWatchlist {
  final WatchlistRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watchlist watchlist) {
    return repository.removeWatchlist(watchlist);
  }
}
